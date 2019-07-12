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

require 'azure/auth/token_provider/azure_cli_token_source'
require 'azure/auth/token_provider/msi_token_source'

# A provider that reads access to Azure MSI token.
module Azure
  module Auth
    class TokenProvider
      class << self
        # Returns an access token
        # @return [AzureMSITokenProvider::Token]
        def token
          @token = read_token_from_source if @token.nil? || @token.is_expired?
        end

        private

        # Reads an access token from one of the known token sources
        # @return [AzureMSITokenProvider::Token]
        def read_token_from_source
          return @selected_source.token unless @selected_source.nil?
          token_sources.each do |ts|
            begin
              t = ts.token
              @selected_source = ts
              return t
            rescue StandardError
              next
            end
          end
        end

        # Returns an array of token sources
        # @return [Array<#token>]
        def token_sources
          [AzureCliTokenSource.new, MsiTokenSource.new]
        end
      end
    end
  end
end
