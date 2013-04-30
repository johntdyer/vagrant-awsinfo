module VagrantAwsInfo

    class Command < Vagrant.plugin(2, :command)
        Settings = Struct.new(:machines,:keys, :pretty)

        def execute

            settings = Settings.new
            settings.machines = []
            settings.keys     = nil

            options = OptionParser.new do |o|
                o.banner = "Return SSH info from an AWS provisioned Vagrant machine"

                o.on("-m MACHINE", "The machine to query.") do |value|
                    settings.machines << value
                end

                o.on("-k KEY", "single value to return.") do |value|
                    settings.keys = value
                end

                o.on("-p", "Pretty print values.") do |value|
                    settings.pretty = true
                end
            end
            argv = parse_options(options)

            settings.machines = ["default"] if settings.machines.empty?

            #@env.ui.debug "[vagrant-awsinfo] - Getting info for machine " + settings.machines.inspect

            instance_info = Hash[ get_info(settings.machines).map{ |k,v| [k.to_s,v] } ]

            if settings.keys
                if instance_info.has_key?(settings.keys)
                    @env.ui.info instance_info[settings.keys].gsub('"', '')
                else
                    @env.ui.error "[WARNING] - Supplied key was not found"
                    return 1
                end
            else
                if settings.pretty
                    jj instance_info
                else
                    @env.ui.info instance_info.to_json
                end
            end

        end

        private

        def get_instance(machine)
            env = machine.action("read_ssh_info")
            region = env[:machine].provider_config.region

            # Get the configs
            region_config     = env[:machine].provider_config.get_region_config(region)

            # Build the fog config
            fog_config = {
                :provider              => :aws,
                :region                => region
            }

            if region_config.use_iam_profile
                fog_config[:use_iam_profile] = True
            else
                fog_config[:aws_access_key_id] = region_config.access_key_id
                fog_config[:aws_secret_access_key] = region_config.secret_access_key
            end

            fog_config[:endpoint] = region_config.endpoint if region_config.endpoint
            fog_config[:version]  = region_config.version if region_config.version
            env[:aws_compute] = Fog::Compute.new(fog_config)
            return env
        end

        def get_info(machine)
            with_target_vms(machine) do |machine|
                if machine.provider_name == :aws
                    env = get_instance(machine)
                    instance = env[:aws_compute].servers.get(machine.id)
                    r = {
                        availability_zone: instance.availability_zone,
                        created_at: instance.created_at,
                        flavor: instance.flavor_id,
                        host: instance.dns_name,
                        public_ip: instance.public_ip_address,
                        private_ip: instance.private_ip_address,
                        private_dns_name: instance.private_dns_name,
                        tags: instance.tags,
                        security_groups: instance.groups,
                        ssh_port: env[:machine_ssh_info][:port],
                        instance_id: machine.id,
                        image_id: instance.image_id,
                        state: machine.provider.state.short_description
                    }

                    r.merge!(network_interfaces: instance.network_interfaces) unless instance.network_interfaces.empty?
                    r.merge!(subnet_id: instance.subnet_id) if instance.subnet_id
                    r.merge!(vpc_id: instance.vpc_id) if instance.vpc_id
                    return r

                else
                    @env.ui.error "[WARNING] - Sorry this plugin currently only supports machines using the AWS provider"
                    exit 1
                end
            end
        end
    end
end
