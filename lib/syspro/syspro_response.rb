require "nokogiri"

module Syspro
  class SysproResponse
    attr_accessor :data, :http_body, :http_headers, :http_status, :request_id

    # Initializes a SysproResponse object from a Hash like the kind returned as
    # part of a Faraday exception.
    def self.from_faraday_hash(http_resp)
      resp = SysproResponse.new
      resp.http_body = http_resp[:body]
      resp.data = Nokogiri::XML(resp.http_body)
      resp.http_headers = http_resp[:headers]
      resp.http_status = http_resp[:status]
      resp.request_id = http_resp[:headers]["Request-Id"]
      resp
    end

    # Initializes a SysproResponse object from a Faraday HTTP response object.
    def self.from_faraday_response(http_resp)
      resp = SysproResponse.new
      resp.http_body = http_resp.body
      resp.data = Nokogiri::XML(resp.http_body)
      resp.http_headers = http_resp.headers
      resp.http_status = http_resp.status
      resp.request_id = http_resp.headers["Request-Id"]
      resp
    end
  end
end
