# frozen_string_literal: true

require 'json'
require 'open3'
require 'time'

require 'azure-msi-token-provider/token'

class AzureMSITokenProvider
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
        { PATH: DEFAULT_AZ_PATH },
        "#{BASH} #{AZ_GET_TOKEN}"
      ) do |_, o, t|
        return nil unless t.value.zero?

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
