# frozen_string_literal: true

require 'syspro/business_objects/parsers/invqry_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class InvQry < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :key_stock_code,
                    :filter_warehouse_list, # seperated by commas
                    :option

      def call(user_id)
        xml_in = template.result(binding)
        business_object = 'INVQRY'
        params = { 'UserId' => user_id, 'BusinessObject' => business_object, 'XmlIn' => xml_in }
        resp = InvQry.query(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/invqry.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = InvQryParser.new(resp[0].data)
        parser.parse
      end

      def render_xml(inner_text, dflt_value = "")
        inner_text ? inner_text.to_s : dflt_value
      end
    end
  end
end
