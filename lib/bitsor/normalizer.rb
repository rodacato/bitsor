# frozen_string_literal: true

require 'time'

module Bitsor
  class Normalizer
    SCHEMAS = {
      account_balances: 'normalize_account_balances',
      account_fees: 'normalize_account_fees',
      account_status: 'normalize_account',
      book: 'normalize_book',
      funding: 'normalize_funding',
      ledger: 'normalize_ledger',
      order: 'normalize_order',
      ticker: 'normalize_ticker',
      trade: 'normalize_trade',
      user_trade: 'normalize_user_trade',
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

    def normalize_funding(response_object)
      response_object[:created_at] = DateTime.parse(response_object[:created_at])
      response_object[:amount] = response_object[:amount].to_f
      response_object
    end

    def normalize_order(response_object)
      response_object[:original_amount] = response_object[:original_amount].to_f
      response_object[:unfilled_amount] = response_object[:unfilled_amount].to_f
      response_object[:original_value] = response_object[:original_value].to_f
      response_object[:price] = response_object[:price].to_f
      response_object[:created_at] = DateTime.parse(response_object[:created_at])
      response_object[:updated_at] = DateTime.parse(response_object[:updated_at])
      response_object
    end

    def normalize_ledger(response_object)
      response_object[:created_at] = DateTime.parse(response_object[:created_at])
      response_object[:balance_updates] = response_object[:balance_updates].map do |balance|
        balance[:amount] = balance[:amount].to_f
        balance
      end
      response_object
    end

    def normalize_ticker(response_object)
      response_object[:volume] = response_object[:volume].to_f
      response_object[:high] = response_object[:high].to_f
      response_object[:last] = response_object[:last].to_f
      response_object[:low] = response_object[:low].to_f
      response_object[:vwap] = response_object[:vwap].to_f
      response_object[:ask] = response_object[:ask].to_f
      response_object[:bid] = response_object[:bid].to_f
      response_object[:created_at] = DateTime.parse(response_object[:created_at])
      response_object
    end

    def normalize_trade(response_object)
      response_object[:amount] = response_object[:amount].to_f
      response_object[:price] = response_object[:price].to_f
      response_object[:created_at] = DateTime.parse(response_object[:created_at])
      response_object
    end

    def normalize_user_trade(response_object)
      response_object[:major] = response_object[:major].to_f
      response_object[:minor] = response_object[:minor].to_f
      response_object[:amount] = response_object[:amount].to_f
      response_object[:fees_amount] = response_object[:fees_amount].to_f
      response_object[:price] = response_object[:price].to_f
      response_object[:tid] = response_object[:tid].to_i
      response_object[:created_at] = DateTime.parse(response_object[:created_at])
      response_object
    end
  end
end

