# vagrant awshost plugin

This plug in helps you get some metadata from an Vagrant machine provisioned with the AWS provider

This is useful when you use want to find out the external IP of the instance you just provisioned


## Installing

```vagrant plugin install vagrant-awshost```


## Querying

The `vagrant awshost` command is provided by this plugin.

Examples:

```
% vagrant awshost
{"host":"ec2-1-2-3-4.compute-1.amazonaws.com","port":22,"private_key_path":"/Users/jdyer/.ssh/example.pem","username":"root"}
```
