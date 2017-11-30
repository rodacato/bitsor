# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'dotenv/load'
require 'bundler/setup'
require 'bitsor'

require 'pry'
require 'webmock/rspec'
require 'vcr'

# Requires supporting ruby files with custom matchers and macros, etc.
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include Bitsor::SpecHelpers

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = 'spec/status.txt'

  config.warnings = false

  config.profile_examples = 10

  Kernel.srand config.seed
end

VCR.configure do |c|
  c.configure_rspec_metadata!

  c.default_cassette_options = {
    serialize_with: :json,
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: :once,
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
end

