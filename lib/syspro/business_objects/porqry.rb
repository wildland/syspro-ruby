# frozen_string_literal: true

require 'syspro/business_objects/parsers/porqry_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class PorQry < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :purchase_order, :include_stocked_lines, :include_non_stocked_lines,
        :include_freight_lines, :include_miscellaneous_lines, :include_comment_lines,
        :include_completed_lines, :include_grns, :include_history, :include_lct_details,
        :include_requisition_details, :include_requisition_routing, :include_sales_orders,
        :include_custom_forms, :filter_type, :filter_value

      def call(user_id)
        xml_in = template.result(binding)
        business_object = 'PORQRY'
        params = {
          'UserId' => user_id,
          'BusinessObject' => business_object,
          'XmlIn' => xml_in
        }
        resp = PorQry.query(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/porqry.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = PorQryParser.new(resp[0].data)
        parser.parse
      end

      def handle_errors(resp)
        body = resp[0].http_body
        raise SysproError, body if body =~ /^(ERROR)/
      end
    end
  end
end

