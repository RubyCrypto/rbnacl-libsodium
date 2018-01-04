# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rbnacl/libsodium/version"

Gem::Specification.new do |spec|
  spec.name          = "rbnacl-libsodium"
  spec.version       = RbNaCl::Libsodium::VERSION
  spec.authors       = ["Artiom Di", "Tony Arcieri"]
  spec.email         = ["kron82@gmail.com", "bascule@gmail.com"]
  spec.summary       = "rbnacl with bundled libsodium"
  spec.homepage      = "https://github.com/cryptosphere/rbnacl-libsodium"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0") + Dir.glob("vendor/libsodium/**/*")
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/rbnacl/extconf.rb"]

  spec.required_ruby_version = ">= 2.2.6"
  spec.add_runtime_dependency "rbnacl", ">= 5.0.0"
  spec.add_development_dependency "bundler", "~> 1.16"
end
