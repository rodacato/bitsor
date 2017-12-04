# frozen_string_literal: true

module Bitsor
  class Normalizer
    SCHEMAS = {
      account_status: 'normalize_account',
      book: 'normalize_book',
    }

    def with(type)
      method = SCHEMAS[type.to_sym] || :null_normalizer

      response = yield

      return response.map do |response_element|
        send method, response_element
      end if response.class == Array

      send method, response
    end

    private

    def null_normalizer(response)
      response
    end

    def normalize_account(response_object)
      response_object[:client_id] = response_object[:client_id].to_i
      response_object[:daily_limit] = response_object[:daily_limit].to_i
      response_object[:monthly_limit] = response_object[:monthly_limit].to_i
      response_object[:daily_remaining] = response_object[:daily_remaining].to_f
      response_object[:monthly_remaining] = response_object[:monthly_remaining].to_f
      response_object
    end

    def normalize_book(response_object)
      response_object[:minimum_price] = response_object[:minimum_price].to_f
      response_object[:maximum_price] = response_object[:maximum_price].to_f
      response_object[:minimum_amount] = response_object[:minimum_amount].to_f
      response_object[:maximum_amount] = response_object[:maximum_amount].to_f
      response_object[:minimum_value] = response_object[:minimum_value].to_f
      response_object[:maximum_value] = response_object[:maximum_value].to_f
      response_object
    end

  end
end

