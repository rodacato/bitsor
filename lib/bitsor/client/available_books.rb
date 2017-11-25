module Bitsor
  class Client
    module AvailableBooks
      def available_books
        get "/available_books"
      end
    end
  end
end
