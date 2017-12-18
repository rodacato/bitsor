# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Ticker do
  include_context 'bitso response schemas'

  describe '#ticker', :vcr do
    it 'returns tickers' do
      response = Bitsor.ticker(book: 'btc_mxn')
      expect(response).to match(ticker_schema)
    end
  end
end

