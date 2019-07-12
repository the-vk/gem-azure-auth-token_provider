# frozen_string_literal: true

#-------------------------------------------------------------------------------
# MIT License
#
# Copyright (c) 2019 Andrew Maraev
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#-------------------------------------------------------------------------------

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'azure-msi-token_provider/version'

Gem::Specification.new do |spec|
  spec.name          = 'azure-msi-token_provider'
  spec.version       = Azure::Auth::TokenProvider::VERSION
  spec.authors       = ['Andrey Maraev']
  spec.email         = ['the_vk@thevk.net']

  spec.summary       = 'A simple to use gem to obtain Azure MSI access token.'
  spec.description   = <<-DESCRIPTION
    A simple to use gem to obtain Azure MSI access token.
    Supports both Azure Cloud environment and local development.
  DESCRIPTION
  spec.homepage      = 'https://github.com/the-vk/gem-azure-auth-token_provider'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.0'
end
