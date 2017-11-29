module Bitsor
  module Configurable
    attr_accessor :client_id, :api_key, :api_secret

    class << self
      def keys
        @keys ||= [
          :client_id,
          :api_key,
          :api_secret,
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      Bitsor::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Bitsor::Default.options[key])
      end
      @last_response = nil
      self
    end
    alias setup reset!

    def api_endpoint
      File.join(@api_endpoint, "")
    end

    private

    def options
      Hash[Bitsor::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end
