# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jittoku_knife/version'

Gem::Specification.new do |spec|
  spec.name          = "jittoku_knife"
  spec.version       = JittokuKnife::VERSION
  spec.authors       = ["Kurokawa"]
  spec.email         = ["black.princess.w@gmail.com"]

  spec.summary       = %q{Jittoku Knife}
  spec.description   = %q{Jittoku Knife}
  spec.homepage      = "https://github.com/BlackPrincess/jittoku_knife"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "test-unit-notify"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-test"
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'coveralls'
end
