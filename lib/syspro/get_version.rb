# frozen_string_literal: true

module Syspro
  class GetVersion < ApiResource
    def self.get_version
      resp = request(:get, resource_url)
      VersionObject.new(resp[0].http_body)
    end

    def resource_url
      '/GetVersion'
    end

    VersionObject = Struct.new(:version)
  end
end
