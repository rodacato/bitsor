require 'date'
require 'json'
require 'openssl'
require 'typhoeus'

require 'bitsor/error'

module Bitsor
  module Connection

    def get(url, options = {})
      request :get, url, nil, parse_query(options)
    end

    def post(url, options = {})
      request :post, url, parse_body(options)
    end

    def put(url, options = {})
      request :put, url, parse_body(options)
    end

    def patch(url, options = {})
      request :patch, url, parse_body(options)
    end

    def delete(url, options = {})
      request :delete, url, parse_body(options)
    end

    def last_response
      @last_response if defined? @last_response
    end

    protected

    def endpoint
      Bitsor::Default.api_endpoint
    end

    private

    def request(method, path, body = nil, params = nil)
      nonce = DateTime.now.strftime('%Q')
      message = nonce + method.to_s.upcase + path + params.to_s + body.to_s
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_secret, message)

      url = "#{endpoint}#{path}#{params}"
      request_options = {
        method: method,
        headers: {
          Authorization: "Bitso #{api_key}:#{nonce}:#{signature}",
          'Content-Type': 'application/json',
        }
      }
      request_options[:body] = body
      response = Typhoeus::Request.new(url, request_options).run
      @last_response = response

      complete_request(response)
    end

    def complete_request(response)
      if error = Bitsor::Error.from_response(response)
        raise error
      end

      JSON.parse(response.body)['payload']
    end

    def parse_query(options)
      return nil if options.empty? || !options

      options = options.select{ |key, value| !value.nil? || (value && !value.empty?) }
      "?#{URI.encode_www_form(options)}"
    end

    def parse_body(options)
      return '' if options.nil? || options.empty?
      options = (options || {}).delete_if { |k, v| v.nil? }
      options.to_json
    end
  end
end
