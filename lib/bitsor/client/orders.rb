# frozen_string_literal: true

module Bitsor
  class Client
    module Orders
      def lookup_order(oid:)
        get("/v3/orders/#{oid}/")
      end

      def place_order(book:, side:, type:, major: nil, minor: nil, price: nil)
        post('/v3/orders/', book: book, side: side, type: type, major: major, minor: minor, price: price)
      end

      def cancel_order(oid:)
        delete("/v3/orders/#{oid}/")
      end
    end
  end
end

