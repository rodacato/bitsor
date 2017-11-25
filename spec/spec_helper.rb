require 'simplecov'
SimpleCov.start

require 'dotenv/load'
require 'bundler/setup'
require 'pry'
require 'bitsor'

require 'webmock/rspec'
require 'vcr'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.configure_rspec_metadata!

  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true,
    :record                     => :once
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

def configure_client
  Bitsor.configure do |config|
    config.api_key = ENV['API_KEY']
    config.api_secret = ENV['API_SECRET']
    config.client_id = ENV['CLIENT_ID']
  end
end
