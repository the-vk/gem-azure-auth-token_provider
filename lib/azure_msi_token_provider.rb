# frozen_string_literal: true

require 'azure-msu-token-provider/azure_cli_token_provider'

# A provider that reads access to Azure MSI token.
class AzureMSITokenProvider
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
      t = nil

      token_sources.each do |ts|
        begin
          t = ts.token
        rescue StandardError
          next
        end
      end

      t
    end

    # Returns an array of token sources
    # @return [Array<#token>]
    def token_sources
      []
    end
  end
end
