module Bitsor
  class Client
    module OpenOrders
      def open_orders(book: :all, marker: nil, sort: :desc, limit: 25)
        get('/v3/open_orders', book: book, marker: maker, sort: sort, limit: limit)
      end
    end
  end
end
