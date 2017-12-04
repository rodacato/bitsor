# frozen_string_literal: true

module Bitsor
  class Client
    module Balance
      def balance
        normalize_response.with(:account_balance) {
          get('/v3/balance/')
        }
      end
    end
  end
end

