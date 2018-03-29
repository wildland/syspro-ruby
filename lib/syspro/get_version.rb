module Syspro
  class GetVersion < ApiResource
    def self.get_version
      resp = self.request(:get, resource_url)
      VersionObject.new(resp[0].http_body)
    end

    def resource_url
      "/GetVersion"
    end

    VersionObject = Struct.new(:version)
  end
end

