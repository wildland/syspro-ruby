require_relative "request"

module Syspro
  module ApiOperations
    class GetVersion
      include ApiOperations::Request

      def get_version
        resp = self.request(:get, resource_url)
        version = VersionObject.new(resp[0].http_body)
      end

      def resource_url
        "/GetVersion"
      end

      VersionObject = Struct.new(:version) do
      end
    end
  end
end

