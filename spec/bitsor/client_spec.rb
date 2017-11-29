require 'spec_helper'
require 'json'

RSpec.describe Bitsor::Client do

  before do
    Bitsor.reset!
  end

  after do
    Bitsor.reset!
  end

  describe "module configuration" do
    before do
      Bitsor.reset!
      Bitsor.configure do |config|
        Bitsor::Configurable.keys.each do |key|
          config.send("#{key}=", "Some #{key}")
        end
      end
    end

    after do
      Bitsor.reset!
    end

    it "inherits the module configuration" do
      client = Bitsor::Client.new
      Bitsor::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq("Some #{key}")
      end
    end

    describe "with class level configuration" do
      before do
        @opts = {
          :client_id => '12345678',
          :api_key => 'AllTheCoins',
          :api_secret => 'aL0veBitso',
        }
      end

      it "overrides module configuration" do
        client = Bitsor::Client.new(@opts)
        expect(client.client_id).to eq('12345678')
        expect(client.api_key).to eq("AllTheCoins")
        expect(client.api_secret).to eq("aL0veBitso")
      end

      it "can set configuration after initialization" do
        client = Bitsor::Client.new
        client.configure do |config|
          @opts.each do |key, value|
            config.send("#{key}=", value)
          end
        end
        expect(client.client_id).to eq('12345678')
        expect(client.api_key).to eq("AllTheCoins")
        expect(client.api_secret).to eq("aL0veBitso")
      end

      it "masks api_key on inspect" do
        client = Bitsor::Client.new(@opts)
        inspected = client.inspect
        expect(inspected).not_to include("aL0veBitso")
      end

      it "doesnt show api secrets on inspect" do
        client = Bitsor::Client.new(:api_secret => '87614b09dd141c22800f96f11737ade5226d7ba8')
        inspected = client.inspect
        expect(inspected).not_to include("87614b09dd141c22800f96f11737ade5226d7ba8")
      end
    end
  end

  describe "headers" do
    it "sets Content-Type header" do
      request = stub_request(:get, %r{v3/available_books}).
        with({
          headers: {
            'Authorization' => /.*/,
            'Content-Type' => 'application/json'
          }
        }).
        to_return(body: "{}")

      Bitsor.client.get "/v3/available_books", {}
      assert_requested request
    end

    it "sets an Authorization header" do
      request = stub_request(:get, %r{v3/balance}).
        with({
          headers: {
            'Authorization' => /.*/,
            'Content-Type' => 'application/json'
          }
        }).
        to_return(body: "{}")

      Bitsor.client.get "/v3/balance", {}
      assert_requested request
    end
  end

  describe "authentication" do
    before do
      Bitsor.reset!
      @client = Bitsor.client
    end

    describe "with module level config" do
      before do
        Bitsor.reset!
      end

      it "sets auth creds with .configure" do
        Bitsor.configure do |config|
          config.client_id = '12345678'
          config.api_key = 'AllTheCoins'
          config.api_secret = 'aL0veBitso'
        end
        expect(Bitsor.client).to be_authenticated
      end

      it "sets auth creds with module methods" do
        Bitsor.client_id = '12345678'
        Bitsor.api_key = 'AllTheCoins'
        Bitsor.api_secret = 'aL0veBitso'
        expect(Bitsor.client).to be_authenticated
      end
    end

    describe "with class level config" do
      it "sets auth creds with .configure" do
        @client.configure do |config|
          config.client_id = '12345678'
          config.api_key = 'AllTheCoins'
          config.api_secret = 'aL0veBitso'
        end
        expect(@client).to be_authenticated
      end

      it "sets auth creds with instance methods" do
        @client.client_id = '12345678'
        @client.api_key = 'AllTheCoins'
        @client.api_secret = 'aL0veBitso'
        expect(@client).to be_authenticated
      end
    end
  end

  describe ".last_response", :vcr do
    before do
      Bitsor.reset!
    end

    it "caches the last request response" do
      client = Bitsor.client
      client.get "/v3/available_books"

      expect(client.last_response.code).to eq(200)
      expect(client.last_response.effective_url.to_s).to eq("https://api-dev.bitso.com:443/v3/available_books")
    end
  end

  describe ".get", :vcr do
    before(:each) do
      Bitsor.reset!
    end

    it "handles query params" do
      Bitsor.get "/v3/ticker", :book => "xrp_mxn"
      assert_requested :get, "https://api-dev.bitso.com/v3/ticker?book=xrp_mxn"
    end
  end

  context "error handling" do
    before do
      Bitsor.reset!
      VCR.turn_off!
    end

    after do
      VCR.turn_on!
    end

    it "raises on 404" do
      stub_request(:get, /booya/).to_return(:status => 404)
      expect { Bitsor.get('/booya') }.to raise_error Bitsor::NotFound
    end

    it "raises on 500" do
      stub_request(:get, /boom/).to_return(:status => 500)
      expect { Bitsor.get('/boom') }.to raise_error Bitsor::InternalServerError
    end

    it "includes a message" do
      stub_request(:get, /boom/).
        to_return ({
          :status => 422,
          :headers => {
            :content_type => "application/json",
          },
          :body => { :status => 422, :error => { :code => '123', :message => "Generic unprocessable entity error" } }.to_json
        })
      begin
        Bitsor.get('/boom')
      rescue Bitsor::UnprocessableEntity => e
        expect(e.message).to include("GET https://api-dev.bitso.com:443/boom")
        expect(e.message).to include("Code 123: Generic unprocessable entity error")
      end
    end

    it "exposes the response" do
      stub_request(:get, /boom/).
        to_return ({
          :status => 422,
          :headers => {
            :content_type => "application/json",
          },
          :body => { :status => 422, :error => { :message => "Generic unprocessable entity error" } }.to_json
        })
      begin
        Bitsor.get('/boom')
      rescue Bitsor::UnprocessableEntity => e
        expect(e).to be_an_instance_of(Bitsor::UnprocessableEntity)
        expect(e.response).to_not be_nil
      end
    end

    it "exposes the request" do
      stub_request(:get, /boom/).
        to_return ({
          :status => 422,
          :headers => {
            :content_type => "application/json",
          },
          :body => { :status => 422, :error => { :message => "Generic unprocessable entity error" } }.to_json
        })
      begin
        Bitsor.get('/boom')
      rescue Bitsor::UnprocessableEntity => e
        expect(e).to be_an_instance_of(Bitsor::UnprocessableEntity)
        expect(e.request).to_not be_nil
      end
    end

    it "exposes the response body" do
      stub_request(:get, /boom/).
        to_return ({
          :status => 422,
          :headers => {
            :content_type => "application/json",
          },
          :body => { :status => 422, :error => { :message => "Generic unprocessable entity error" } }.to_json
        })
      begin
        Bitsor.get('/boom')
      rescue Bitsor::UnprocessableEntity => e
        expect(e).to be_an_instance_of(Bitsor::UnprocessableEntity)
        expect(e.body).to_not be_nil
      end
    end
  end
end
