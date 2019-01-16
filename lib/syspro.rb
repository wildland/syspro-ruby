# frozen_string_literal: true

require 'cgi'
require 'faraday'
require 'json'
require 'logger'
require 'openssl'
require 'forwardable'

require 'syspro/configuration'
require 'syspro/api_resource'
require 'syspro/errors'
require 'syspro/get_logon_profile'
require 'syspro/get_version'
require 'syspro/logoff'
require 'syspro/logon'
require 'syspro/syspro_client'
require 'syspro/singleton_api_resource'
require 'syspro/syspro_object'
require 'syspro/syspro_response'
require 'syspro/util'
require 'syspro/version'

require 'syspro/api_operations/request'
require 'syspro/api_operations/query'
require 'syspro/api_operations/transaction'
require 'syspro/api_operations/setup'

require 'syspro/business_objects/combrw'
require 'syspro/business_objects/comfch'
require 'syspro/business_objects/comfnd'
require 'syspro/business_objects/sorqry'
require 'syspro/business_objects/portor'
require 'syspro/business_objects/portoi'
require 'syspro/business_objects/porqry'
require 'syspro/business_objects/comsfm'
require 'syspro/business_objects/invsws'

require 'syspro/business_objects/models/sor'
require 'syspro/business_objects/models/sor_detail'
require 'syspro/business_objects/models/por_detail'

require 'syspro/business_objects/models/purchase_order'
require 'syspro/business_objects/models/purchase_orders/header'
require 'syspro/business_objects/models/purchase_orders/order_details'
require 'syspro/business_objects/models/purchase_orders/stock_line'
require 'syspro/business_objects/models/purchase_orders/freight_line'
require 'syspro/business_objects/models/purchase_orders/misc_charge_line'
require 'syspro/business_objects/models/purchase_orders/comment_line'

require 'syspro/business_objects/models/comsfm_item'
require 'syspro/business_objects/models/invsws_item'

require 'syspro/business_objects/parsers/combrw_parser'
require 'syspro/business_objects/parsers/comfch_parser'
require 'syspro/business_objects/parsers/comfnd_parser'
require 'syspro/business_objects/parsers/sorqry_parser'
require 'syspro/business_objects/parsers/portor_parser'
require 'syspro/business_objects/parsers/portoi_parser'
require 'syspro/business_objects/parsers/comsfm_parser'
require 'syspro/business_objects/parsers/invsws_parser'

# Main Module
module Syspro
  # Options that should be persisted between API requests. This includes
  # client, which is an object containing an HTTP client to reuse.
  OPTS_PERSISTABLE = (
    Set[:client]
  ).freeze

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  # Delegate old deprecated configuration
  class << self
    def configure
      yield configuration
    end

    def configuration
      Configuration.instance
    end

    def api_base
      @api_base || "#{configuration.server_url}/SYSPROWCFService/Rest"
    end

    def api_base=(url)
      warn "[DEPRECATION] `api_base=` is deprecated. Please use `configuration.server_url=` instead."
      @api_base = url
    end

    private

    def deprecate_config(name)
      define_singleton_method(name) { call_deprecated_config(name) }
      define_singleton_method("#{name}=") { |v| call_deprecated_config("#{name}=", v) }
    end

    def call_deprecated_config(name, *args)
      warn "[DEPRECATION] `#{name}` is deprecated. Please use `configuration.#{name}` instead."
      configuration.send(name, *args)
    end
  end

  deprecate_config :open_timeout
  deprecate_config :read_timeout
  deprecate_config :log_level
  deprecate_config :logger
  deprecate_config :max_network_retries
end
