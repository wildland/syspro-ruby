# frozen_string_literal: true

require 'syspro/business_objects/parsers/sorqry_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class SorQry < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :sales_order, :invoice, :stocked_lines, :non_stocked_lines, :freight_lines,
                    :misc_lines, :comment_lines, :completed_lines, :serials, :lots, :bins,
                    :attached_items, :custom_forms, :detail_line_custom_forms, :values, :line_ship_date

      def call(user_id)
        xml_in = template.result(binding)
        business_object = 'SORQRY'
        params = { 'UserId' => user_id, 'BusinessObject' => business_object, 'XmlIn' => xml_in }
        resp = SorQry.query(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/sorqry.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = SorQryParser.new(resp[0].data)
        parser.parse
      end
    end
  end
end
