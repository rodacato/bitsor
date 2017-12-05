# frozen_string_literal: true

module Bitsor
  class Error < StandardError
    def self.from_response(response)
      status = response.response_code

      if klass =  case status
                  when 400      then Bitsor::BadRequest
                  when 401      then Bitsor::Forbidden
                  when 403      then Bitsor::Forbidden
                  when 404      then Bitsor::NotFound
                  when 405      then Bitsor::MethodNotAllowed
                  when 406      then Bitsor::NotAcceptable
                  when 422      then Bitsor::UnprocessableEntity
                  when 400..499 then Bitsor::ClientError
                  when 500      then Bitsor::InternalServerError
                  when 501      then Bitsor::NotImplemented
                  when 502      then Bitsor::BadGateway
                  when 503      then Bitsor::ServiceUnavailable
                  when 500..599 then Bitsor::ServerError
                  end
        klass.new(response)
      end
    end

    def initialize(response = nil)
      @response = response
      @request = response.request
      @body = { error: {} }

      begin
        if response.body && !response.body.empty?
          @body = JSON.parse(response.body, symbolize_names: true)
        end
      rescue JSON::ParserError => e
        @body = { error: { code: response.response_code, message: 'Internal Server Error: An Error Was Encountered' } }
      end

      super(build_error_message)
    end

    def build_error_message
      return nil if @response.nil?
      message =  ["#{@request.options[:method].to_s.upcase} "]
      message << @response.options[:effective_url].to_s + "\n"
      message << "Code #{@body[:error][:code]}: #{@body[:error][:message]} \n"
      message.join
    end

    attr_accessor :response, :request, :body
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when 403 HTTP status code
  class TooManyRequests < Forbidden; end

  # Raised when 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when 405 HTTP status code
  class MethodNotAllowed < ClientError; end

  # Raised when 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when 503 HTTP status code
  class ServiceUnavailable < ServerError; end
end

