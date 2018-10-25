# frozen_string_literal: true

require 'syspro/business_objects/parsers/combrw_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class ComBrw < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :browse_name, :start_at_key, :start_condition, :return_rows, :filters,
                    :table_name, :title, :columns

      def call(user_id, raw)
        xml_in = template.result(binding)
        params = { 'UserId' => user_id, 'XmlIn' => xml_in }
        resp = ComBrw.browse(params)
        unless raw
          parse_response(resp)
        else
          resp
        end
      end

      def template
        ERB.new(
          File.read(
            File.expand_path('schemas/combrw.xml.erb', File.dirname(__FILE__))
          ),
          nil,
          '%'
        )
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = ComBrwParser.new(resp[0].data)
        parser.parse
      end
    end
  end
end
