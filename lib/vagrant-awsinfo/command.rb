module VagrantAwsInfo

    class Command < Vagrant.plugin(2, :command)

        Settings = Struct.new(:machines)

        def execute

            require "optparse"

            settings = Settings.new
            settings.machines = []

            options = OptionParser.new do |o|
                o.banner = "Return SSH info from an AWS provisioned Vagrant machine"
                o.on("-m MACHINE", "The machine to query.") do |value|
                    settings.machines << value
                end
            end
            settings.machines = ["default"] if settings.machines.empty?

            @env.ui.info get_info(settings.machines)

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
                     return r.to_json

                else
                    return "Sorry this plugin currently only supports the AWS provider"
                end
            end
        end
    end
end
