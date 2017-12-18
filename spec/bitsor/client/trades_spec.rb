# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Trades do
  include_context 'bitso response schemas'

  describe '#trades', :vcr do
    it 'returns recent trades' do
      response = Bitsor.trades(book: 'btc_mxn')
      expect(response).to match(
        array_including(match(trade_schema))
      )
    end
  end
end

