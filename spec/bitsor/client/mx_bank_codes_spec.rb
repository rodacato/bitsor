# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::MxBankCodes do
  include_context 'bitso response schemas'

  describe '#mx_bank_codes', :vcr do
    it 'returns mx bank codes' do
      response = Bitsor.mx_bank_codes
      expect(response).to match(
        array_including(match(mx_bank_code_schema))
      )
    end
  end
end

