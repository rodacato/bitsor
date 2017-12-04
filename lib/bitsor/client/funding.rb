# frozen_string_literal: true

module Bitsor
  class Client
    module Funding
      def fundings(limit: 25)
        normalize_response.with(:funding) {
          get('/v3/fundings/', limit: limit)
        }
      end
    end
  end
end

