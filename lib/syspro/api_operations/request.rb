module Syspro
  module ApiOperations
    module Request
      module ClassMethods
        def request(method, url, params = {}, opts = {})
          warn_on_opts_in_params(params)

          opts = Util.normalize_opts(opts)
          opts[:client] ||= SysproClient.active_client

          headers = opts.clone
          user_id = headers.delete(:user_id)
          client = headers.delete(:client)
          # Assume all remaining opts must be headers

          resp = client.execute_request(
            method, url,
            headers: headers,
            user_id: user_id,
            params: params
          )

          resp
        end

        private

        def warn_on_opts_in_params(params)
          Util::OPTS_USER_SPECIFIED.each do |opt|
            if params.key?(opt)
              $stderr.puts("WARNING: #{opt} should be in opts instead of params.")
            end
          end
        end
      end # ClassMethods

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end

