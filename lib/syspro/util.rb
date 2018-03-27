module Syspro
  class Util
    # Options that a user is allowed to specify.
    OPTS_USER_SPECIFIED = Set[
      # :syspro_version
    ].freeze


    def self.objects_to_ids(h)
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
    def self.convert_to_syspro_object(data, opts = {})
      case data
      when Array
        data.map { |i| convert_to_syspro_object(i, opts) }
      when Hash
        # Try converting to a known object class.  If none available, fall back to generic SysproObject
        object_classes.fetch(data[:object], SysproObject).construct_from(data, opts)
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
        raise TypeError, "normalize_opts expects a string or a hash"
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
          k = titlecase_parts(k.to_s.tr("_", "-"))
        elsif k.is_a?(String)
          k = titlecase_parts(k)
        end

        new_headers[k] = v
      end
    end

    def self.encode_parameters(params)
      Util.flatten_params(params)
          .map { |k, v| "#{url_encode(k)}=#{url_encode(v)}" }.join("&")
    end

    def self.flatten_params(params, parent_key = nil)
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
      if !Syspro.logger.nil? ||
         !Syspro.log_level.nil? && Syspro.log_level <= Syspro::LEVEL_ERROR
        log_internal(message, data, color: :cyan,
                                    level: Syspro::LEVEL_ERROR, logger: Syspro.logger, out: $stderr)
      end
    end

    def self.log_info(message, data = {})
      if !Syspro.logger.nil? ||
         !Syspro.log_level.nil? && Syspro.log_level <= Syspro::LEVEL_INFO
        log_internal(message, data, color: :cyan,
                                    level: Syspro::LEVEL_INFO, logger: Syspro.logger, out: $stdout)
      end
    end

    def self.log_debug(message, data = {})
      if !Syspro.logger.nil? ||
         !Syspro.log_level.nil? && Syspro.log_level <= Syspro::LEVEL_DEBUG
        log_internal(message, data, color: :blue,
                                    level: Syspro::LEVEL_DEBUG, logger: Syspro.logger, out: $stdout)
      end
    end

  end
end

