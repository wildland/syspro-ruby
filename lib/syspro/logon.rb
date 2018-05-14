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
      handle_errors(resp)
      UserIdObject.new(resp[0].http_body)
    end

    def resource_url
      '/Logon'
    end

    def self.handle_errors(resp)
      body = resp[0].http_body
      raise AuthenticationError, body if body =~ /^(ERROR)/
    end

    UserIdObject = Struct.new(:guid)
  end
end
