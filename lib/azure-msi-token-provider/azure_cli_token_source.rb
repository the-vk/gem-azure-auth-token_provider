# frozen_string_literal: true

class AzureMSITokenProvider
  # A token source that gets token using cli tool az
  class AzureCliTokenSource
    # Returns an access token from cli tool az
    # @return [AzureMSITokenProvider::Token]
    def token
      nil
    end
  end
end
