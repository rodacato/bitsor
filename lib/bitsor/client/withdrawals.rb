module Bitsor
  class Client
    module Withdrawals
      def withdrawals(limit: 25)
        get('/v3/withdrawals', limit: limit)
      end
    end
  end
end
