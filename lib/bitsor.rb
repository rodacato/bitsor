require 'bitsor/client'
require 'bitsor/default'
require 'bitsor/error'

module Bitsor
  class << self
    include Bitsor::Configurable

    def client
      return @client if defined?(@client)
      @client = Bitsor::Client.new(options)
    end

    private

    def respond_to_missing?(method_name, include_private=false)
      client.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end

      super
    end
  end
end

Bitsor.setup




# require 'active_support'
# require 'active_support/core_ext'
# require 'active_support/inflector'
# require 'active_model'
# require 'rest-client'
#
#
#
# String.send(:include, ActiveSupport::Inflector)
#
# module Bitsor
#   mattr_accessor :api_key
#   mattr_accessor :api_secret
#   mattr_accessor :client_id
#
#   # Currency
#   mattr_accessor :currency
#   @@currency = :mxn
#
#   def self.configure
#     yield self
#   end
#
#
  # def self.orders
  #   self.sanity_check!
  #
  #   @@orders ||= Bitso::Orders.new
  # end
  #
  # def self.user_transactions
  #   self.sanity_check!
  #
  #   @@transactions ||= Bitso::UserTransactions.new
  # end
  #
  # def self.transactions
  #   return Bitso::Transactions.from_api
  # end
  #
  # def self.balance
  #   self.sanity_check!
  #   return Bitso::Balance.from_api
  # end

# end
