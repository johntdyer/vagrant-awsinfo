# vagrant awsinfo plugin

This plug in helps you get some metadata from an Vagrant machine provisioned with the AWS provider

This is useful when you use want to find out the external IP, instanceID, or username of the instance you just provisioned


## Installing

```vagrant plugin install vagrant-awsinfo```


## Querying

The `vagrant awsinfo` command is provided by this plugin.

Examples:

```
% vagrant awsinfo
{:host=>"ec2-xxx-xxx-xxx-xxxx.compute-1.amazonaws.com", :ssh_port=>22, :username=>"root", :instance_id=>"i-3188a75e", :state=>"running"}

% vagrant awsinfo -k host
ec2-174-129-128-49.compute-1.amazonaws.com

% vagrant awsinfo -k host -m default
ec2-174-129-128-49.compute-1.amazonaws.com
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

John Dyer (johntdyer@gmail.com)
