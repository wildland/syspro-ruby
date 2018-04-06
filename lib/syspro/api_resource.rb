# frozen_string_literal: true

require 'syspro/syspro_object'
require 'syspro/api_operations/request'

module Syspro
  class ApiResource < SysproObject
    include Syspro::ApiOperations::Request

    def self.class_name
      name.split('::')[-1]
    end

    def self.resource_url
      if self == ApiResource
        raise NotImplementedError, 'APIResource is an abstract class.  You should perform actions on its subclasses (Charge, Customer, etc.)'
      end
      "/#{CGI.escape(class_name.downcase)}"
    end

    def refresh
      resp, opts = request(:get, resource_url, @retrieve_params)
      initialize_from(resp.data, opts)
    end

    def self.retrieve(id, opts = {})
      opts = Util.normalize_opts(opts)
      instance = new(id, opts)
      instance.refresh
      instance
    end
  end
end
