# frozen_string_literal: true

module Bitsor
  class Client
    module UserTrades
      def user_trades(book:, marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:user_trade) do
          get('/v3/user_trades/', book: book, marker: marker, sort: sort, limit: limit)
        end
      end
    end
  end
end

