module Bitsor
  class Client
    module OrderTrades
      def order_trades(oid:)
        get('/v3/order_trades/'+oid)
      end
    end
  end
end
