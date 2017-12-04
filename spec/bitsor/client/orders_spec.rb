# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Orders do
  include_context 'bitso response schemas'

  describe '#lookup_order' do
    let :simple_order_options do
      {
        book: 'btc_mxn',
        side: 'sell',
        type: 'limit',
        major: 0.05,
        price: 400000
      }
    end

    it 'returns order details' do
      order = Bitsor.place_order(simple_order_options)
      response = Bitsor.lookup_order(order)
      Bitsor.cancel_order(order)

      expect(response).to include(order_schema)
      expect(response.first[:status]).to eq('open')
    end

    context 'fulfilled orders' do
      it 'returns the order details' do
        response = Bitsor.lookup_order(oid: 'jfeZlSFf2heNnRqg')
        expect(response).to include(order_schema)
        expect(response.first[:status]).to eq('completed')
      end
    end

    context 'cancelled orders' do
      it 'returns the order details' do
        response = Bitsor.lookup_order(oid: 'RQbMyzSuww5Yu7ej')
        expect(response).to include(order_schema)
        expect(response.first[:status]).to eq('cancelled')
      end
    end
  end

  describe '#place_order', :vcr do
    let :simple_order_options do
      {
        book: 'btc_mxn',
        side: 'sell',
        type: 'limit',
        major: 0.05,
        price: 200000
      }
    end

    it 'places an order', :vcr do
      response = Bitsor.place_order(simple_order_options)
      expect(response).to include(oid: 'jfeZlSFf2heNnRqg')
    end
  end

  describe '#cancel_order', :vcr do
    let :simple_order_options do
      {
        book: 'btc_mxn',
        side: 'sell',
        type: 'limit',
        major: 0.05,
        price: 400000
      }
    end

    it 'returns the cancelled order id', :vcr do
      order = Bitsor.place_order(simple_order_options)
      response = Bitsor.cancel_order(order)
      expect(response).to eq([order[:oid]])
    end

    context 'order fulfilled' do
      it 'returns an empty array', :vcr do
        response = Bitsor.cancel_order(oid: 'jfeZlSFf2heNnRqg')
        expect(response).to eq([])
      end
    end
  end
end

