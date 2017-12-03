module Bitsor
  class Base
    attr_reader :response

    protected

    def execute_request
      @response = yield
      normalize_response
      response
    end

    def normalize_response
      response
    end
  end
end
