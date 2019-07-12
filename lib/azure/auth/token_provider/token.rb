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

require 'date'

module Azure
  module Auth
    class TokenProvider
      # Azure OAuth2 access token
      class Token
        # Initializes new instance of Token
        # @param access_token [String] JWT access token
        # @param expires_on [Time] Date and time when token expires
        # @param token_type [String] Token type
        # @param ext [Hash] extra data
        def initialize(access_token, expires_on, token_type, ext)
          @access_token = access_token
          @expires_on = expires_on
          @token_type = token_type

          @subscription = ext.fetch(:subscription, nil)
          @tenant = ext.fetch(:tenant, nil)
          @client_id = ext.fetch(:client_id, nil)
          @expires_in = ext.fetch(:expires_in, nil)
          @ext_expires_in = ext.fetch(:ext_expires_in, nil)
          @not_before = ext.fetch(:not_before, nil)
          @resource = ext.fetch(:resource, nil)
        end

        # JWT access token
        # @return [String]
        attr_reader :access_token

        # Date and time when token expires
        # @return [Time]
        attr_reader :expires_on

        # Azure subscription id
        # @return [String]
        attr_reader :subscription

        # Azure app tenant id
        # @return [String]
        attr_reader :tenant

        # Token type
        # @return [String]
        attr_reader :token_type

        # Client Id
        # @return [String]
        attr_reader :client_id

        # TTL in seconds
        # @return [Number]
        attr_reader :expires_in

        # Ext expires in
        # @return [Time]
        attr_reader :ext_expires_in

        # Date and time before which token is not valid
        # @return [Time]
        attr_reader :not_before

        # URI of resource token is valid for
        # @return [String]
        attr_reader :resource

        # Is token expired?
        # @return [Boolean]
        def expired?
          Time.now > @expires_on
        end
      end
    end
  end
end
