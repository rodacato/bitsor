# frozen_string_literal: true

module Bitsor
  class Client
    module AvailableBooks
      def available_books
        normalize_response.with(:book) do
          get '/v3/available_books'
        end
      end
    end
  end
end

