# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-awsinfo/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-awsinfo"
  spec.version       = VagrantAwsInfo::VERSION
  spec.authors       = ["John Dyer"]
  spec.email         = ["johntdyer@gmail.com"]
  spec.description   = 'vagrant aws info querying plugin'
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/johntdyer/vagrant-awsinfo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
