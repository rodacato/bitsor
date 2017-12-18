# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitsor::Client::AvailableBooks do
  include_context 'bitso response schemas'

  describe '#available_books', :vcr do
    it 'returns the user account status ' do
      response = Bitsor.available_books
      expect(response).to match(
        array_including(match(book_schema))
      )
    end
  end
end

