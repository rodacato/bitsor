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

  describe ".client" do
    it "creates an Bitsor::Client" do
      expect(Bitsor.client).to be_kind_of Bitsor::Client
    end

    it "caches the client when the same options are passed" do
      expect(Bitsor.client).to eq(Bitsor.client)
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

