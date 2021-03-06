# frozen_string_literal: true

module Bitsor
  class Client
    module Trades
      def trades(book:, marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:trade) do
          get('/v3/trades/', book: book, marker: marker, sort: sort, limit: limit)
        end
      end
    end
  end
end

