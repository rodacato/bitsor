# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Fees do
  include_context 'bitso response schemas'

  describe '#fees', :vcr do
    it 'returns the user fees' do
      response = Bitsor.fees
      expect(response).to match(account_fees_schema)
    end
  end
end

