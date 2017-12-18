
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitsor/version'

Gem::Specification.new do |spec|
  spec.name          = 'bitsor'
  spec.version       = Bitsor::VERSION
  spec.authors       = ['Adrian Castillo']
  spec.email         = ['rodacato@gmail.com']

  spec.summary       = 'Unofficial Ruby API wrapper for use with Bitso.'
  spec.description   = 'Manage your bitso account from their API endpoints'
  spec.homepage      = 'https://www.bitsotower.com'
  spec.license       = 'MIT'
  spec.metadata      = { "source_code_uri" => "https://github.com/rodacato/bitsor" }

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'typhoeus', '~> 1.3'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end

