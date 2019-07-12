# frozen_string_literal: true

require 'date'

module Azure
  module Auth
    class TokenProvider
      # Azure OAuth2 access token
      class Token
        # Initializes new instance of Token
        # @param access_token [String] JWT access token
        # @param expires_on [Time] Date and time when token expires
        # @param subscription [String] Azure subscription id
        # @param tenant [String] Azure AD app tenant id
        # @param token_type [String] Token type
        def initialize(access_token, expires_on, subscription, tenant, token_type)
          @access_token = access_token
          @expires_on = expires_on
          @subscription = subscription
          @tenant = tenant
          @token_type = token_type
        end

        # JWT access token
        # @return [String]
        attr_reader :access_token

        # Date and time when token expires
        # @return [Date]
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

        # Is token expired?
        # @return [Boolean]
        def expired?
          Time.now > @expires_on
        end
      end
    end
  end
end
