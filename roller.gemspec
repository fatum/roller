# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roller/version'

Gem::Specification.new do |spec|
  spec.name          = "roller"
  spec.version       = Roller::VERSION
  spec.authors       = ["Maxim Fillippovich"]
  spec.email         = ["fatumka@gmail.com"]
  spec.summary       = "Full feature rich deployment"
  spec.description   = "Full feature rich deployment"
  spec.homepage      = "http://twitter.com/mfilippovich"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables = %w[roller]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.3.5"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
