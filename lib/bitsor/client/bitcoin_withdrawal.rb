# frozen_string_literal: true

module Bitsor
  class Client
    module BitcoinWithdrawal
      def bitcoin_withdrawal
        raise Bitsor::NotImplemented
      end
    end
  end
end

