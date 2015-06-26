# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scope_delegation/version'

Gem::Specification.new do |spec|
  spec.name          = "scope_delegation"
  spec.version       = ScopeDelegation::VERSION
  spec.authors       = ["Foraker"]
  spec.email         = ["jle@foraker.com"]

  spec.summary       = %q{Easily delegate scopes to associations in Rails.}
  spec.description   = %q{Helps to reduce boilerplate for joining and merging scopes. Write fewer characters and be happier.}
  spec.homepage      = "https://github.com/foraker/scope_delegation"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
