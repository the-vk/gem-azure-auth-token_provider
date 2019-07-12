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

require 'net/http'
require 'uri'

require 'azure/auth/token_provider/token'

module Azure
  module Auth
    class TokenProvider
      # Provdes OAuth 2.0 access token by calling Azure MV IDMS
      class MsiTokenSource
        AZURE_VM_IDMS_ENDPOINT =
          'http://169.254.169.254/metadata/identity/oauth2/token'
        API_VERSION = 'api-version=2018-02-01'
        DEFAULT_RESOURCE = 'https://management.azure.com'

        def token(resource = DEFAULT_RESOURCE)
          query_params = "#{API_VERSION}&resource=#{resource}"
          uri_src = "#{AZURE_VM_IDMS_ENDPOINT}?#{query_params}"
          uri = URI.parse(uri_src)
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri.request_uri)
          request['Metadata'] = 'true'
          response = http.request(request)
          return nil if response.code != '200'

          parse_json_token(response.body)
        end

        private

        def parse_json_token(token_src)
          token_hash = JSON.parse(token_src)
          Token.new(
            token_hash['access_token'],
            Time.at(token_hash['expires_on'].to_i),
            token_hash['token_type'],
            read_ext(token_hash)
          )
        end

        def read_ext(token_hash)
          {
            client_id: token_hash['client_id'],
            expires_in: token_hash['expires_in'].to_i,
            ext_expires_in: token_hash['ext_expires_in'].to_i,
            not_before: Time.at(token_hash['not_before'].to_i),
            resource: token_hash['resource']
          }
        end
      end
    end
  end
end
