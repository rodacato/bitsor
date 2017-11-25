module Bitsor
  class Client
    module Funding
      def funding(limit: 25)
        get('/v3/fundings', limit: limit)
      end
    end
  end
end
