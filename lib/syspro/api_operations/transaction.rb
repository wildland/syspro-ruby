# frozen_string_literal: true

module Syspro
  module ApiOperations
    module Transaction
      module ClassMethods
        def post(params)
          request(:get, '/Transaction/Post', params)
        end

        private

        def warn_on_opts_in_params(params)
          Util::OPTS_USER_SPECIFIED.each do |opt|
            if params.key?(opt)
              warn("WARNING: #{opt} should be in opts instead of params.")
            end
          end
        end
      end # ClassMethods

      def self.included(base)
        base.extend(ClassMethods)
      end

      protected

      def request(method, url, params = {}, opts ={})
        opts = @opts.merge(Util.normalize_opts(opts))
        Request.request(method, url, params, opts)
      end
    end
  end
end

