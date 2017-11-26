module Bitsor
  class Client
    module UserTrades
      def user_trades(book:, marker: nil, sort: :desc, limit: 25)
        get('/v3/user_trades/', book: book, marker: marker, sort: sort, limit: limit)
      end
    end
  end
end
