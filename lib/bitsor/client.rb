require 'bitsor/error'

require 'bitsor/concerns/configurable'
require 'bitsor/concerns/rate_limit'
require 'bitsor/concerns/connection'

require 'bitsor/client/account_status'
require 'bitsor/client/available_books'
require 'bitsor/client/balance'
require 'bitsor/client/bitcoin_withdrawal'
require 'bitsor/client/debit_card_withdrawal'
require 'bitsor/client/ether_withdrawal'
require 'bitsor/client/fees'
require 'bitsor/client/funding'
require 'bitsor/client/funding_destination'
require 'bitsor/client/kyc_documents'
require 'bitsor/client/ledger'
require 'bitsor/client/mx_bank_codes'
require 'bitsor/client/open_orders'
require 'bitsor/client/open_trades'
require 'bitsor/client/order_book'
require 'bitsor/client/order_trades'
require 'bitsor/client/orders'
require 'bitsor/client/phone_number'
require 'bitsor/client/phone_number_withdrawal'
require 'bitsor/client/phone_verification'
require 'bitsor/client/spei_withdrawal'
require 'bitsor/client/ticker'
require 'bitsor/client/trades'
require 'bitsor/client/user_trades'
require 'bitsor/client/withdrawals'

module Bitsor
  class Client
    include Bitsor::Configurable
    include Bitsor::Connection

    include Bitsor::Client::AccountStatus
    include Bitsor::Client::AvailableBooks
    include Bitsor::Client::Balance
    include Bitsor::Client::BitcoinWithdrawal
    include Bitsor::Client::DebitCardWithdrawal
    include Bitsor::Client::EtherWithdrawal
    include Bitsor::Client::Fees
    include Bitsor::Client::Funding
    include Bitsor::Client::FundingDestination
    include Bitsor::Client::KycDocuments
    include Bitsor::Client::Ledger
    include Bitsor::Client::MxBankCodes
    include Bitsor::Client::OpenOrders
    include Bitsor::Client::OpenTrades
    include Bitsor::Client::OrderBook
    include Bitsor::Client::OrderTrades
    include Bitsor::Client::Orders
    include Bitsor::Client::PhoneNumber
    include Bitsor::Client::PhoneNumberWithdrawal
    include Bitsor::Client::PhoneVerification
    include Bitsor::Client::SpeiWithdrawal
    include Bitsor::Client::Ticker
    include Bitsor::Client::Trades
    include Bitsor::Client::UserTrades
    include Bitsor::Client::Withdrawals

    def initialize(options = {})
      Bitsor::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Bitsor.instance_variable_get(:"@#{key}"))
      end
    end

    def inspect
      inspected = super

      inspected = inspected.gsub! @api_secret, "*******" if @api_secret
      inspected = inspected.gsub! @api_key, "******#{@api_key[6..-1]}" if @api_key
      inspected = inspected.gsub! @client_id, "****#{@client_id[4..-1]}" if @client_id
      inspected
    end

    def client_id=(value)
      @client_id = value
    end

    def api_key=(value)
      @api_key = value
    end

    def api_secret=(value)
      @api_secret = value
    end
  end
end
