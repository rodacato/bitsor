# frozen_string_literal: true

module Bitsor
  class Client
    module FundingDestination
      def funding_destination(fund_currency:)
        normalize_response.with(:funding_destination) do
          get('/v3/funding_destination/', fund_currency: fund_currency)
        end
      end
    end
  end
end

