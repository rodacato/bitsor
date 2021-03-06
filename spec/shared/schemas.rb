# frozen_string_literal: true

shared_context 'bitso response schemas' do
  let :account_status_schema do
    a_hash_including(
      client_id: kind_of(Integer),
      first_name: kind_of(String),
      last_name: kind_of(String),
      status: kind_of(String),
      daily_limit: kind_of(Integer),
      monthly_limit: kind_of(Integer),
      daily_remaining: kind_of(Float),
      monthly_remaining: kind_of(Float),
      cellphone_number: kind_of(String),
      cellphone_number_stored: kind_of(String),
      email_stored: kind_of(String),
      official_id: kind_of(String),
      proof_of_residency: kind_of(String),
      signed_contract: kind_of(String),
      origin_of_funds: kind_of(String),
      verification_level: kind_of(Integer),
      referral_code: kind_of(String)
    )
  end

  let :account_balances_schema do
    a_hash_including(
      balances: array_including(match(balance_schema))
    )
  end

  let :account_fees_schema do
    a_hash_including(
      fees: array_including(match(fee_schema)),
      withdrawal_fees: a_hash_including(
        btc: kind_of(Float),
        eth: kind_of(Float)
      )
    )
  end

  let :fee_schema do
    a_hash_including(
      book: kind_of(String),
      fee_percent: kind_of(Float),
      fee_decimal: kind_of(Float)
    )
  end

  let :balance_schema do
    a_hash_including(
      currency: kind_of(String),
      available: kind_of(Float),
      locked: kind_of(Float),
      total: kind_of(Float),
      pending_deposit: kind_of(Float),
      pending_withdrawal: kind_of(Float)
    )
  end

  let :book_schema do
    a_hash_including(
      book: kind_of(String),
      minimum_price: kind_of(Float),
      maximum_price: kind_of(Float),
      minimum_amount: kind_of(Float),
      maximum_amount: kind_of(Float),
      minimum_value: kind_of(Float),
      maximum_value: kind_of(Float)
    )
  end

  let :funding_schema do
    a_hash_including(
      fid: kind_of(String),
      status: kind_of(String),
      created_at: kind_of(DateTime),
      currency: kind_of(String),
      method: kind_of(String),
      method_name: kind_of(String),
      amount: kind_of(Float),
      details: a_hash_including(
        sender_name: kind_of(String),
        sender_clabe: kind_of(String),
        sender_bank: kind_of(String),
        clave: kind_of(String),
        clave_rastreo: kind_of(String),
        numeric_reference: kind_of(String),
        concepto: kind_of(String)
      )
    )
  end

  let :order_schema do
    a_hash_including(
      book: kind_of(String),
      original_amount: kind_of(Float),
      unfilled_amount: kind_of(Float),
      original_value: kind_of(Float),
      created_at: kind_of(DateTime),
      updated_at: kind_of(DateTime),
      price: kind_of(Float),
      oid: kind_of(String),
      side: kind_of(String),
      status: kind_of(String),
      type: kind_of(String)
    )
  end

  let :funding_destination_schema do
    a_hash_including(
      account_identifier_name: kind_of(String),
      account_identifier: kind_of(String)
    )
  end

  let :ledger_schema do
    a_hash_including(
      eid: kind_of(String),
      operation: kind_of(String),
      created_at: kind_of(DateTime),
      balance_updates: array_including(
        a_hash_including(
          currency: kind_of(String),
          amount: kind_of(Float)
        )
      ),
      details: kind_of(Hash)
    )
  end

  let :ledger_details_schema do
    a_hash_including(
      tid: kind_of(String),
      oid: kind_of(String)
    )
  end

  let :ledger_funding_details_schema do
    a_hash_including(
      fid: kind_of(String),
      method: kind_of(String),
      method_name: kind_of(String)
    )
  end

  let :mx_bank_code_schema do
    a_hash_including(
      code: kind_of(String),
      name: kind_of(String)
    )
  end

  let :ticker_schema do
    a_hash_including(
      book: kind_of(String),
      volume: kind_of(Float),
      high: kind_of(Float),
      last: kind_of(Float),
      low: kind_of(Float),
      vwap: kind_of(Float),
      ask: kind_of(Float),
      bid: kind_of(Float),
      created_at: kind_of(DateTime)
    )
  end

  let :trade_schema do
    a_hash_including(
      book: kind_of(String),
      amount: kind_of(Float),
      maker_side: kind_of(String),
      price: kind_of(Float),
      tid: kind_of(Integer),
      created_at: kind_of(DateTime)
    )
  end

  let :user_trade_schema do
    a_hash_including(
      book: kind_of(String),
      created_at: kind_of(DateTime),
      minor: kind_of(Float),
      major: kind_of(Float),
      fees_amount: kind_of(Float),
      fees_currency: kind_of(String),
      minor_currency: kind_of(String),
      major_currency: kind_of(String),
      oid: kind_of(String),
      tid: kind_of(Integer),
      price: kind_of(Float),
      side: kind_of(String),
      amount: kind_of(Float)
    )
  end
end

