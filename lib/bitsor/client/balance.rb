module Bitsor
  class Client
    module Balance
      def balance
        get('/v3/balance/')
      end
    end
  end
end