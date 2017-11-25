module Bitsor
  class Client
    module FundingDestination
      def funding_destination
        raise Bitsor::NotImplemented
      end
    end
  end
end
