module Bitsor
  class Client
    module Trades
      def trades(book:, marker: nil, sort: :desc, limit: 25)
        get('/trades', { book: book, marker: marker, sort: sort, limit: limit })
      end
    end
  end
end
