module Bitsor
  class Client
    module OrderBook
      def order_book(book:, aggregate: false)
        get('/order_book', book: book, aggregate: aggregate)
      end
    end
  end
end
