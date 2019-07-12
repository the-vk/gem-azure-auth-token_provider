# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'azure-msi-token-provider/version'

Gem::Specification.new do |spec|
  spec.name          = 'azure-msi-token-provider'
  spec.version       = AzureMSITokenProvider::VERSION
  spec.authors       = ['Andrey Maraev']
  spec.email         = ['the_vk@thevk.net']

  spec.summary       = 'A simple to use gem to obtain Azure MSI access token.'
  spec.description   = <<-DESCRIPTION
    A simple to use gem to obtain Azure MSI access token.
    Supports both Azure Cloud environment and local development.
  DESCRIPTION
  spec.homepage      = 'https://github.com/the-vk/gem-azure-msi-token-provider'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.0'
end
