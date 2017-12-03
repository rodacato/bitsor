# frozen_string_literal: true

require 'bitsor/client/base'

module Bitsor
  class Client < Base
    module AccountStatus
      def account_status
        execute_request {
          get('/v3/account_status/')
        }
      end

      private

      def normalize_response
        response[:client_id] = response[:client_id].to_i
        response[:daily_limit] = response[:daily_limit].to_i
        response[:monthly_limit] = response[:monthly_limit].to_i
        response[:daily_remaining] = response[:daily_remaining].to_f
        response[:monthly_remaining] = response[:monthly_remaining].to_f
      end
    end
  end
end

