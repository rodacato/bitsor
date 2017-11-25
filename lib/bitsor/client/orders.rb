module Bitsor
  class Client
    module Orders
      def lookup_orders(oid:)
        get('/v3/orders/'+oid)
      end

      def orders
        raise Bitsor::NotImplemented
      end
    end
  end
end
