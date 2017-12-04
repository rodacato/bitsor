# frozen_string_literal: true

module Bitsor
  class Client
    module AccountStatus
      def account_status
        normalize_response.with(:account_status) {
          get('/v3/account_status/')
        }
      end
    end
  end
end

