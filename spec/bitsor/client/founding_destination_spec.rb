# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::FundingDestination do
  include_context 'bitso response schemas'

  describe '#funding', :vcr do
    it 'returns the user fundings ' do
      response = Bitsor.funding_destination(fund_currency: 'btc')
      expect(response).to match(funding_destination_schema)
    end

    context 'errors' do
      it 'requires the fund_currency' do
        expect {
          Bitsor.funding_destination
        }.to raise_error(ArgumentError)
      end
    end
  end
end
