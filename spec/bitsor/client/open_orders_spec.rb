# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::OpenOrders do
  include_context 'bitso response schemas'

  describe '#open_orders', :vcr do
    it 'returns user open orders' do
      response = Bitsor.open_orders(book: 'btc_mxn')
      expect(response).to match(
        array_including(match(order_schema))
      )
    end
  end
end

