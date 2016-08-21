# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_interface/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_interface'
  spec.version       = RubyInterface::VERSION
  spec.authors       = ['Kirill Klimuk']
  spec.email         = ['kklimuk@gmail.com']

  spec.summary       = %q{Interfaces for Ruby.}
  spec.description   = %q{When a class is interpreted and does not have the required methods, it throws an error.}
  spec.homepage      = 'https://github.com/kklimuk/ruby_interface'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'rspec'
end
