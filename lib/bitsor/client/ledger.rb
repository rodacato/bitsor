# frozen_string_literal: true

module Bitsor
  class Client
    module Ledger
      def ledger(marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:ledger) do
          get('/v3/ledger/', marker: marker, sort: sort, limit: limit)
        end
      end

      def ledger_trades(marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:ledger) do
          get('/v3/ledger/trades/', marker: marker, sort: sort, limit: limit)
        end
      end

      def ledger_fees(marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:ledger) do
          get('/v3/ledger/fees/', marker: marker, sort: sort, limit: limit)
        end
      end

      def ledger_fundings(marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:ledger) do
          get('/v3/ledger/fundings/', marker: marker, sort: sort, limit: limit)
        end
      end

      def ledger_withdrawals(marker: nil, sort: :desc, limit: 25)
        normalize_response.with(:ledger) do
          get('/v3/ledger/withdrawals/', marker: marker, sort: sort, limit: limit)
        end
      end
    end
  end
end

