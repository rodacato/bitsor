# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::Funding do
  include_context 'bitso response schemas'

  describe '#funding', :vcr do
    it 'returns the user fundings' do
      response = Bitsor.fundings
      expect(response).to match(
        array_including(match(funding_schema))
      )
    end

    it 'supports limit parameter' do
      response = Bitsor.fundings(limit: 1)
      expect(response.count).to eq(1)
    end
  end
end
