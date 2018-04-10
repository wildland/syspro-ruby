# frozen_string_literal: true

module Syspro
  class Logon < ApiResource
    def self.logon(username, password, company_id, company_password = nil)
      params = {
        'Operator' => username,
        'OperatorPassword' => password,
        'CompanyId' => company_id,
        'CompanyPassword' => company_password
      }
      resp = request(:get, resource_url, params)
      UserIdObject.new(resp[0].http_body)
    end

    def resource_url
      '/Logon'
    end

    UserIdObject = Struct.new(:guid)
  end
end
