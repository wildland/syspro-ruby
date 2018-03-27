require "cgi"
require "faraday"
require "json"
require "logger"
require "openssl"

require "syspro/api_resource"
require "syspro/syspro_client"
require "syspro/singleton_api_resource"
require "syspro/syspro_object"
require "syspro/syspro_response"
require "syspro/util"
require "syspro/version"

require "syspro/api_operations/get_version"
require "syspro/api_operations/request"


module Syspro
  @api_base = "http://syspro.wildlandlabs.com:90/SYSPROWCFService/Rest"

  @open_timeout = 30
  @read_timeout = 80

  @log_level = nil
  @logger = nil

  @max_network_retries = 0
  @max_network_retry_delay = 2
  @initial_network_retry_delay = 0.5

  class << self
    attr_accessor :api_base, :open_timeout, :read_timeout
  end

  # Options that should be persisted between API requests. This includes
  # client, which is an object containing an HTTP client to reuse.
  OPTS_PERSISTABLE = (
    Set[:client]
  ).freeze

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  # When set prompts the library to log some extra information to $stdout and
  # $stderr about what it's doing. For example, it'll produce information about
  # requests, responses, and errors that are received. Valid log levels are
  # `debug` and `info`, with `debug` being a little more verbose in places.
  #
  # Use of this configuration is only useful when `.logger` is _not_ set. When
  # it is, the decision what levels to print is entirely deferred to the logger.
  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    # Backwards compatibility for values that we briefly allowed
    if val == "debug"
      val = LEVEL_DEBUG
    elsif val == "info"
      val = LEVEL_INFO
    end

    if !val.nil? && ![LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO].include?(val)
      raise ArgumentError, "log_level should only be set to `nil`, `debug` or `info`"
    end
    @log_level = val
  end

  # Sets a logger to which logging output will be sent. The logger should
  # support the same interface as the `Logger` class that's part of Ruby's
  # standard library (hint, anything in `Rails.logger` will likely be
  # suitable).
  #
  # If `.logger` is set, the value of `.log_level` is ignored. The decision on
  # what levels to print is entirely deferred to the logger.
  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

  def self.max_network_retries
    @max_network_retries
  end

  def self.max_network_retries=(val)
    @max_network_retries = val.to_i
  end

  Stripe.log_level = ENV["STRIPE_LOG"] unless ENV["STRIPE_LOG"].nil?
end
