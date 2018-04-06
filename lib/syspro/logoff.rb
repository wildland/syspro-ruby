# frozen_string_literal: true

module Syspro
  class Logoff < ApiResource
    def self.logoff(user_id)
      params = { 'UserId' => user_id }
      resp = request(:get, resource_url, params)

      if resp[0].http_body == '0'
        true
      else
        resp[0].http_body
      end
    end

    def resource_url
      '/Logoff'
    end
  end
end
