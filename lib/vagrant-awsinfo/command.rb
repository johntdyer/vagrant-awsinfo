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

            with_target_vms(settings.machines) do |machine|
                if machine.provider_name == :aws
                    @env.ui.info machine.provider.ssh_info.to_json
                else
                    @env.ui.error "Sorry this plugin currently only supports the AWS provider"
                end
            end
        end
    end
end
