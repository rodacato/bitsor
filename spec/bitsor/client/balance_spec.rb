# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Balance do
  include_context 'bitso response schemas'

  describe '#balance', :vcr do
    it 'returns the user account balance' do
      response = Bitsor.balance
      expect(response).to match(account_balances_schema)
    end
  end
end

