# frozen_string_literal: true

module Bitsor
  class Normalizer
    SCHEMAS = {
      account_status: 'normalize_account',
      account_balances: 'normalize_account_balances',
      account_fees: 'normalize_account_fees',
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

    def normalize_account_balances(response_object)
      response_object[:balances] = response_object[:balances].map do |balance|
        balance[:available] = balance[:available].to_f
        balance[:locked] = balance[:locked].to_f
        balance[:total] = balance[:total].to_f
        balance[:pending_deposit] = balance[:pending_deposit].to_f
        balance[:pending_withdrawal] = balance[:pending_withdrawal].to_f
        balance
      end
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

    def normalize_account_fees(response_object)
      response_object[:fees] = response_object[:fees].map do |fee|
        fee[:fee_percent] = fee[:fee_percent].to_f
        fee[:fee_decimal] = fee[:fee_decimal].to_f
        fee
      end
      response_object[:withdrawal_fees][:btc] = response_object[:withdrawal_fees][:btc].to_f
      response_object[:withdrawal_fees][:eth] = response_object[:withdrawal_fees][:eth].to_f
      response_object
    end
  end
end

