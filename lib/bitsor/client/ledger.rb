module Bitsor
  class Client
    module Ledger
      def ledger(marker: nil, sort: :desc, limit: 25)
        get('/v3/ledger', maker: maker, sort: sort, limit: limit)
      end

      def ledger_trades(marker: nil, sort: :desc, limit: 25)
        get('/v3/ledger/trades', maker: maker, sort: sort, limit: limit)
      end

      def ledger_fees(marker: nil, sort: :desc, limit: 25)
        get('/v3/ledger/fees', maker: maker, sort: sort, limit: limit)
      end

      def ledger_fees(marker: nil, sort: :desc, limit: 25)
        get('/v3/ledger/fundings', maker: maker, sort: sort, limit: limit)
      end

      def ledger_fees(marker: nil, sort: :desc, limit: 25)
        get('/v3/ledger/withdrawals', maker: maker, sort: sort, limit: limit)
      end
    end
  end
end
