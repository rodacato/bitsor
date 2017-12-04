# frozen_string_literal: true

module Bitsor
  class Client
    module Fees
      def fees
        normalize_response.with(:account_fees) {
          get('/v3/fees/')
        }
      end
    end
  end
end

