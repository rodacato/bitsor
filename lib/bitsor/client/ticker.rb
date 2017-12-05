# frozen_string_literal: true

module Bitsor
  class Client
    module Ticker
      def ticker(book:)
        normalize_response.with(:ticker) {
          get('/v3/ticker/', book: book)
        }
      end
    end
  end
end

