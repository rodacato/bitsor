module Bitsor
  class Client
    module Funding
      def fundings(limit: 25)
        get('/v3/fundings/', limit: limit)
      end
    end
  end
end
