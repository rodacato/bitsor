# frozen_string_literal: true

module Bitsor
  class Client
    module Fees
      def fees
        get('/v3/fees/')
      end
    end
  end
end

