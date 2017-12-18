# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::AccountStatus do
  include_context 'bitso response schemas'

  describe '#account_status', :vcr do
    it 'returns the user account status ' do
      response = Bitsor.account_status
      expect(response).to match(account_status_schema)
    end
  end
end

