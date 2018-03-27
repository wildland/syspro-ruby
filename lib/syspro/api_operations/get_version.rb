require_relative "request"

module Syspro
  module ApiOperations
    class GetVersion
      include ApiOperations::Request

      def resource_url
        "/GetVersion"
      end
    end
  end
end

