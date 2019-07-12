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

require 'json'
require 'open3'
require 'time'

require 'azure/auth/token_provider/token'

module Azure
  module Auth
    class TokenProvider
      # A token source that gets token using cli tool az
      class AzureCliTokenSource
        DEFAULT_AZ_PATH = '/usr/bin:/usr/local/bin'
        BASH = '/bin/bash'
        AZ_GET_TOKEN = 'az account get-access-token -o json'

        # Returns an access token from cli tool az
        # @return [AzureMSITokenProvider::Token]
        def token
          if Gem.win_platform?
            token_windows
          else
            token_nix
          end
        end

        private

        # Calls az on windows OS
        # @return [AzureMSITokenProvider::Token]
        def token_windows
          # TODO
          nil
        end

        # Calls az on *nix OS
        # @return [AzureMSITokenProvider::Token]
        def token_nix
          Open3.popen2(
            { "PATH" => DEFAULT_AZ_PATH },
            "#{BASH} #{AZ_GET_TOKEN}"
          ) do |_, o, t|
            return nil unless t.value == 0

            return parse_json_token(o.read)
          end
        end

        def parse_json_token(token_src)
          token_hash = JSON.parse(token_src)
          Token.new(
            token_hash['accessToken'],
            Time.parse(token_hash['expiresOn']),
            token_hash['subscription'],
            token_hash['tenant'],
            token_hash['tokenType']
          )
        end
      end
    end
  end
end
