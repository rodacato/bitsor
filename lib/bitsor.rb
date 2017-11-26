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

