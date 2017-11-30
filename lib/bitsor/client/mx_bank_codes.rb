# frozen_string_literal: true

module Bitsor
  class Client
    module MxBankCodes
      def mx_bank_codes
        get('/v3/mx_bank_codes/')
      end
    end
  end
end

