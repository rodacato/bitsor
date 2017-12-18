# frozen_string_literal: true

module Bitsor
  module Authorizable
    def authenticated?
      !!(@client_id && @api_key && @api_secret)
    end
  end
end

