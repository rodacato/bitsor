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
end
