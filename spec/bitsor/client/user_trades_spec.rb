# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::UserTrades do
  include_context 'bitso response schemas'

  describe '#user_trades', :vcr do
    it 'returns user trades' do
      response = Bitsor.user_trades(book: 'btc_mxn')
      expect(response).to match(
        array_including(match(user_trade_schema))
      )
    end
  end
end

