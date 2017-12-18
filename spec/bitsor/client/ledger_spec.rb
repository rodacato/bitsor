# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Ledger do
  include_context 'bitso response schemas'

  describe '#ledger', :vcr do
    it 'returns other users ledgers' do
      response = Bitsor.ledger
      expect(response).to match(
        array_including(match(ledger_schema))
      )
      expect(response.first[:details]).to match(ledger_details_schema)
    end
  end

  describe '#ledger_trades', :vcr do
    it 'returns other users ledgers trades' do
      response = Bitsor.ledger_trades
      expect(response).to match(
        array_including(match(ledger_schema))
      )
      expect(response.first[:details]).to match(ledger_details_schema)
    end
  end

  describe '#ledger_fees', :vcr do
    it 'returns other users ledgers fees' do
      response = Bitsor.ledger_fees
      expect(response).to match(
        array_including(match(ledger_schema))
      )
      expect(response.first[:details]).to match(ledger_details_schema)
    end
  end

  describe '#ledger_fundings', :vcr do
    it 'returns other users ledgers fundings' do
      response = Bitsor.ledger_fundings
      expect(response).to match(
        array_including(match(ledger_schema))
      )
      expect(response.first[:details]).to match(ledger_funding_details_schema)
    end
  end

  describe '#ledger_withdrawals', :vcr do
    xit 'returns other users ledgers withdrawals' do
      response = Bitsor.ledger_withdrawals
      expect(response).to match(
        array_including(match(ledger_schema))
      )
    end
  end
end

