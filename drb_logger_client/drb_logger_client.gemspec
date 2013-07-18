# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'drb_logger_client/version'

Gem::Specification.new do |spec|
  spec.name          = "drb_logger_client"
  spec.version       = DrbLoggerClient::VERSION
  spec.authors       = ["Aaron Cruz"]
  spec.email         = ["aaron@aaroncruz.com"]
  spec.description   = %q{drb logger client}
  spec.summary       = %q{drb logger client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
