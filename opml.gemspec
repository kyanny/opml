# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opml/version'

Gem::Specification.new do |spec|
  spec.name          = "opml"
  spec.version       = Opml::VERSION::STRING
  spec.authors       = ["Joshua Peek"]
  spec.email         = ["josh@joshpeek.com"]
  spec.description   = %q{A simple wrapper for parsing OPML files.}
  spec.summary       = %q{A simple wrapper for parsing OPML files.}
  spec.homepage      = "http://rubyforge.org/projects/opml/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 3.2.12"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
