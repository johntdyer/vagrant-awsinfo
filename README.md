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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

John Dyer (johntdyer@gmail.com)
