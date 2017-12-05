# frozen_string_literal: true

module Bitsor
  class Client
    module OpenOrders
      def open_orders(book: :all, marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:order) do
          get('/v3/open_orders/', book: book, marker: marker, sort: sort, limit: limit)
        end
      end
    end
  end
end

