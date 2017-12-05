# frozen_string_literal: true

require 'spec_helper'
require 'json'

RSpec.describe Bitsor::Error do
  before do
    Bitsor.reset!
  end

  after do
    Bitsor.reset!
  end

  describe 'internal server error' do
    it 'handles bitso internal errors', :vcr do
      expect {
        Bitsor.funding_destination(fund_currency: 'btc')
      }.to raise_error(Bitsor::InternalServerError)
    end
  end
end
