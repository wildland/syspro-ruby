require 'singleton'

module Syspro
  class Configuration
    include Singleton

    attr_accessor :server_url,
                  :open_timeout,
                  :read_timeout,
                  :logger,
                  :max_network_retries
    attr_reader :log_level

    def initialize
      self.server_url = ENV['SYSPRO_SERVER'] || deprecated_default_server_url
      self.open_timeout = 30
      self.read_timeout = 80
      self.log_level = ENV['SYSPRO_LOG_LEVEL'] || deprecated_syspro_env
      self.logger = nil
      self.max_network_retries = 0
    end

    # When set prompts the library to log some extra information to $stdout and
    # $stderr about what it's doing. For example, it'll produce information about
    # requests, responses, and errors that are received. Valid log levels are
    # `debug` and `info`, with `debug` being a little more verbose in places.
    #
    # Use of this configuration is only useful when `.logger` is _not_ set. When
    # it is, the decision what levels to print is entirely deferred to the logger.
    def log_level=(val)
      # Backwards compatibility for values that we briefly allowed
      val = ::Syspro::LEVEL_DEBUG if val == 'debug'
      val = ::Syspro::LEVEL_INFO if val == 'info'
      if !val.nil? && ![::Syspro::LEVEL_DEBUG, ::Syspro::LEVEL_ERROR, ::Syspro::LEVEL_INFO].include?(val)
        raise(
          ArgumentError,
          'log_level should only be set to `nil`, `debug` or `info`'
        )
      end
      @log_level = val
    end

    private

    def deprecated_default_server_url
      warn '[DEPRECATION] the default server url of `http://syspro.wildlandlabs.com:90` will be removed. Please update your application to configure this server url (see README for details).'
      'http://syspro.wildlandlabs.com:90'
    end

    def deprecated_syspro_env
      if ENV['SYSPRO_LOG']
        warn "[DEPRECATION] `ENV['SYSPRO_LOG']` is deprecated.  Please use `ENV['SYSPRO_LOG_LEVEL']` instead."
      end

      ENV['SYSPRO_LOG']
    end
  end
end
