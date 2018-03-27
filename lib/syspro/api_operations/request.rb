module Syspro
  module ApiOperations
    module Request
      def request(method, url, params = {}, opts = {})
          client = SysproClient.active_client

          headers = opts.clone

          resp = client.execute_request(
            method, url,
            headers: headers,
            params: params
          )

          resp
      end

      def warn_on_opts_in_params(params)
          Util::OPTS_USER_SPECIFIED.each do |opt|
            if params.key?(opt)
              $stderr.puts("WARNING: #{opt} should be in opts instead of params.")
            end
          end
      end
    end
  end
end

