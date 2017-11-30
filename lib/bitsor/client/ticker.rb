# frozen_string_literal: true

module Bitsor
  class Client
    module Ticker
      def ticker(book:)
        get('/v3/ticker/', book: book)
      end
    end
  end
end

