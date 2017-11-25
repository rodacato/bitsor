require "spec_helper"

RSpec.describe Bitsor do
  before do
    Bitsor.reset!
  end

  after do
    Bitsor.reset!
  end

  it "sets defaults" do
    Bitsor::Configurable.keys.each do |key|
      expect(Bitsor.instance_variable_get(:"@#{key}")).to eq(Bitsor::Default.send(key))
    end
  end

  it "test live harness" do
    # configure_client
    # binding.pry
  end

  describe ".client" do
    it "creates an Bitsor::Client" do
      expect(Bitsor.client).to be_kind_of Bitsor::Client
    end

    it "caches the client when the same options are passed" do
      expect(Bitsor.client).to eq(Bitsor.client)
    end

    xit "returns a fresh client when options are not the same" do
      client = Bitsor.client
      Bitsor.api_key = "87614b09dd141c22800f96f11737ade5226d7ba8"
      client_two = Bitsor.client
      client_three = Bitsor.client
      expect(client).not_to eq(client_two)
      expect(client_three).to eq(client_two)
    end
  end

  describe ".configure" do
    Bitsor::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Bitsor.configure do |config|
          config.send("#{key}=", key)
        end
        expect(Bitsor.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end
end

