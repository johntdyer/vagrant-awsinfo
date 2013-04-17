module VagrantAwsInfo

    class Command < Vagrant.plugin(2, :command)

        Settings = Struct.new(:machines,:keys)

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
            end

            settings.machines = ["default"] if settings.machines.empty?

            argv = parse_options(options)

            instance_info = Hash[ get_info(settings.machines).map{ |k,v| [k.to_s,v] } ]

            if settings.keys
                if instance_info.has_key?(settings.keys)
                    @env.ui.info instance_info[settings.keys].gsub('"', '')
                else
                    @env.ui.error "[WARNING] - Supplied key was not found"
                    return 1
                end
            else
                @env.ui.info instance_info.to_json
            end

        end

        private

        def get_info(machine)
            with_target_vms(machine) do |machine|
                if machine.provider_name == :aws
                    ssh_info = machine.provider.ssh_info
                    r = {
                        host: ssh_info[:host],
                        ssh_port: ssh_info[:port],
                        username: ssh_info[:username],
                        instance_id: machine.id,
                        state: machine.provider.state.short_description,
                    }
                     return r
                else
                    @env.ui.error "[WARNING] - Sorry this plugin currently only supports machines using the AWS provider"
                    exit 1
                end
            end
        end
    end
end
