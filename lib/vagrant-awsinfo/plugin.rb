module VagrantAwsInfo
  class Plugin < Vagrant.plugin("2")
    name "Query SSH info from AWS guests."

    command "awsinfo" do
      require_relative "command"
      next VagrantAwsInfo::Command
    end
  end
end
