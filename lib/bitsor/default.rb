require 'bitsor/version'

module Bitsor

  module Default

    API_ENDPOINT = "https://api.bitso.com/v3".freeze

    class << self

      def options
        Hash[Bitsor::Configurable.keys.map{|key| [key, send(key)]}]
      end

      def client_id
        ENV['CLIENT_ID']
      end

      def api_key
        ENV['API_KEY']
      end

      def api_secret
        ENV['API_SECRET']
      end

      def api_endpoint
        ENV['API_ENDPOINT'] || API_ENDPOINT
      end
    end
  end

end
