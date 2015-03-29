# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proxi_clean/version'

Gem::Specification.new do |spec|
  spec.name          = "proxi_clean"
  spec.version       = ProxiClean::VERSION
  spec.authors       = ["Mario Zigliotto"]
  spec.email         = ["mariozig@gmail.com"]

  spec.summary       = %q{Proxi Clean will check your proxy and tell you if it's working or not.}
  spec.description   = %q{Proxi Clean will check your proxy and tell you if it's working or not.}
  spec.homepage      = "http://github.com/mariozig/proxi_clean"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rest-client', '~> 1.8', '>= 1.8.0'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'vcr', '~> 2.9', '>= 2.9.3'
  spec.add_development_dependency 'webmock', '~> 1.20', '>= 1.20.4'
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
end
