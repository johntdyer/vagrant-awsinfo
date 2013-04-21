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

% vagrant awsinfo -k host -m default -p
{
  "availability_zone": "us-east-1c",
  "created_at": "2013-04-20T20:51:10Z",
  "flavor": "m1.medium",
  "host": "ec2-50-16-48-88.compute-1.amazonaws.com",
  "public_ip": "50.16.48.88",
  "private_ip": "10.151.111.73",
  "private_dns_name": "ip-10-151-111-73.ec2.internal",
  "tags": {
    "Name": "Vagrant-PhonoGateway",
    "OwnerHostname": "dyer.local",
    "CreatedAt": "2013-04-20T 4:46:37",
    "OwnerUsername": "jdyer"
  },
  "groups": [
    "everything_open"
  ],
  "ssh_port": 22,
  "instance_id": "i-28f14e43",
  "state": "running"
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

John Dyer (johntdyer@gmail.com)
