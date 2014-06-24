# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'respond_with_service/version'

Gem::Specification.new do |spec|
  spec.name          = "respond_with_service"
  spec.version       = RespondWithService::VERSION
  spec.authors       = ["Pierre-Alexandre Piarulli"]
  spec.email         = ["go@rubyrock.me"]
  spec.summary       = %q{like respond_with but with service.}
  spec.description   = %q{first write for none standar database + active_admin app and then open as a gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
