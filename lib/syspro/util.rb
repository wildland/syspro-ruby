# frozen_string_literal: true

module Syspro
  # Utillity class
  class Util # rubocop:disable Metrics/ClassLength
    # Options that a user is allowed to specify.
    OPTS_USER_SPECIFIED = Set[
      :user_id
    ].freeze

    # Options that should be copyable from one StripeObject to another
    # including options that may be internal.
    OPTS_COPYABLE = (
      OPTS_USER_SPECIFIED + Set[:api_base]
    ).freeze

    # Options that should be persisted between API requests. This includes
    # client, which is an object containing an HTTP client to reuse.
    OPTS_PERSISTABLE = (
      OPTS_USER_SPECIFIED + Set[:client]
    ).freeze

    def self.objects_to_ids(h) # rubocop:disable Metrics/MethodLength, Metrics/LineLength, Naming/UncommunicativeMethodParamName
      case h
      when ApiResource
        h.id
      when Hash
        res = {}
        h.each { |k, v| res[k] = objects_to_ids(v) unless v.nil? }
        res
      when Array
        h.map { |v| objects_to_ids(v) }
      else
        h
      end
    end

    # Converts a hash of fields or an array of hashes into a +SysproObject+ or
    # array of +SysproObject+s. These new objects will be created as a concrete
    # type as dictated by their `object` field (e.g. an `object` value of
    # `charge` would create an instance of +Charge+), but if `object` is not
    # present or of an unknown type, the newly created instance will fall back
    # to being a +SysproObject+.
    #
    # ==== Attributes
    #
    # * +data+ - Hash of fields and values to be converted into a SysproObject.
    # * +opts+ - Options for +SysproObject+ like an API key that will be reused
    #   on subsequent API calls.
    def self.convert_to_syspro_object(data, opts = {}) # rubocop:disable Metrics/LineLength, Metrics/MethodLength
      case data
      when Array
        data.map { |i| convert_to_syspro_object(i, opts) }
      when Hash
        # Try converting to a known object class.
        # If none available, fall back to generic SysproObject
        object_classes.fetch(
          data[:object],
          SysproObject
        ).construct_from(data, opts)
      else
        data
      end
    end

    # The secondary opts argument can either be a string or hash
    # Turn this value into an api_key and a set of headers
    def self.normalize_opts(opts)
      case opts
      when String
        opts
      when Hash
        opts.clone
      else
        raise TypeError, 'normalize_opts expects a string or a hash'
      end
    end

    # Normalizes header keys so that they're all lower case and each
    # hyphen-delimited section starts with a single capitalized letter. For
    # example, `request-id` becomes `Request-Id`. This is useful for extracting
    # certain key values when the user could have set them with a variety of
    # diffent naming schemes.
    def self.normalize_headers(headers)
      headers.each_with_object({}) do |(k, v), new_headers|
        if k.is_a?(Symbol)
          k = titlecase_parts(k.to_s.tr('_', '-'))
        elsif k.is_a?(String)
          k = titlecase_parts(k)
        end

        new_headers[k] = v
      end
    end

    def self.encode_parameters(params)
      Util.flatten_params(params)
          .map { |k, v| "#{url_encode(k)}=#{url_encode(v)}" }.join('&')
    end

    def self.flatten_params(params, parent_key = nil) # rubocop:disable Metrics/LineLength, Metrics/MethodLength
      result = []

      # do not sort the final output because arrays (and arrays of hashes
      # especially) can be order sensitive, but do sort incoming parameters
      params.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{key}]" : key.to_s
        if value.is_a?(Hash)
          result += flatten_params(value, calculated_key)
        elsif value.is_a?(Array)
          check_array_of_maps_start_keys!(value)
          result += flatten_params_array(value, calculated_key)
        else
          result << [calculated_key, value]
        end
      end

      result
    end

    def self.log_error(message, data = {})
      if !Syspro.logger.nil? || !Syspro.log_level.nil? && Syspro.log_level <= Syspro::LEVEL_ERROR # rubocop:disable Style/GuardClause, Metrics/LineLength
        log_internal(
          message,
          data,
          color: :cyan,
          level: Syspro::LEVEL_ERROR,
          logger: Syspro.logger,
          out: $stderr
        )
      end
    end

    def self.log_info(message, data = {})
      if !Syspro.logger.nil? || !Syspro.log_level.nil? && Syspro.log_level <= Syspro::LEVEL_INFO # rubocop:disable Style/GuardClause, Metrics/LineLength
        log_internal(
          message,
          data,
          color: :cyan,
          level: Syspro::LEVEL_INFO,
          logger: Syspro.logger,
          out: $stdout
        )
      end
    end

    def self.log_debug(message, data = {})
      if !Syspro.logger.nil? || !Syspro.log_level.nil? && Syspro.log_level <= Syspro::LEVEL_DEBUG # rubocop:disable Style/GuardClause, Metrics/LineLength
        log_internal(
          message,
          data,
          color: :blue,
          level: Syspro::LEVEL_DEBUG,
          logger: Syspro.logger,
          out: $stdout
        )
      end
    end

    def self.url_encode(key)
      CGI.escape(key.to_s).
        # Don't use strict form encoding by changing the square bracket control
        # characters back to their literals. This is fine by the server, and
        # makes these parameter strings easier to read.
        gsub('%5B', '[').gsub('%5D', ']')
    end

    # TODO: Make these named required arguments when we drop support for Ruby
    # 2.0.
    def self.log_internal(message, data = {}, color: nil, level: nil, logger: nil, out: nil) # rubocop:disable Metrics/LineLength, Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists
      data_str = data.reject { |_k, v| v.nil? }.map do |(k, v)|
        format(
          '%s=%s', # rubocop:disable Style/FormatStringToken
          colorize(k, color, !out.nil? && out.isatty),
          wrap_logfmt_value(v)
        )
      end.join(' ')

      if !logger.nil?
        # the library's log levels are mapped to the same values as the
        # standard library's logger
        logger.log(
          level,
          format(
            'message=%s %s', # rubocop:disable Style/FormatStringToken
            wrap_logfmt_value(message),
            data_str
          )
        )
      elsif out.isatty
        out.puts format(
          '%s %s %s', # rubocop:disable Style/FormatStringToken
          colorize(level_name(level)[0, 4].upcase, color, out.isatty),
          message,
          data_str
        )
      else
        out.puts format(
          'message=%s level=%s %s', # rubocop:disable Style/FormatStringToken
          wrap_logfmt_value(message),
          level_name(level),
          data_str
        )
      end
    end
    private_class_method :log_internal
  end
end
