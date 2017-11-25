module Bitsor
  class Client
    module Ticker
      def ticker(book:)
        get('/ticker', book: book)
      end
    end
  end
end
