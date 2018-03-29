module Syspro
  class SysproError < StandardError
    attr_reader :message, :response, :code, :http_body, :http_headers,
                :http_status, :data, :request_id

    # Initializes a SysproError.
    def initialize(message = nil, http_status: nil, http_body: nil, data: nil,
                   http_headers: nil, code: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @http_headers = http_headers || {}
      @data = data
      @code = code
      @request_id = @http_headers[:request_id]
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
      id_string = @request_id.nil? ? "" : "(Request #{@request_id}) "
      "#{status_string}#{id_string}#{@message}"
    end
  end

  class AuthenticationError < SysproError
  end

  class ApiConnectionError < SysproError
  end

  class ApiError < SysproError
  end

end
