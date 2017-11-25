require "spec_helper"

RSpec.describe Bitsor do
  it "harness" do
    Bitsor.configure do |config|
      config.api_key = ENV['API_KEY']
      config.api_secret = ENV['API_SECRET']
      config.client_id = ENV['CLIENT_ID']
    end
    #
    # client = Bitsor::V3::Client.new

    binding.pry
  end
end
