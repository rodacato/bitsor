# frozen_string_literal: true

module Bitsor
  module SpecHelpers
    def configure_client
      Bitsor.configure do |config|
        config.api_key = ENV['API_KEY']
        config.api_secret = ENV['API_SECRET']
        config.client_id = ENV['CLIENT_ID']
      end
    end
  end
end

