# frozen_string_literal: true

require 'syspro/business_objects/parsers/portoi_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class PorToi < ApiResource
      include Syspro::ApiOperations::Transaction
      include Syspro::BusinessObjects::Parsers

      # input params
      attr_accessor :purchase_order_header,
        :purchase_order_details,
        :validate_only,
        :ignore_warnings,
        :allow_non_stock_items,
        :allow_zero_price,
        :validate_working_days,
        :allow_po_when_blanket_po,
        :default_memo_code,
        :fixed_exchange_rate,
        :default_memo_days,
        :allow_blank_ledger_code,
        :calc_due_date,
        :default_delivery_address,
        :insert_dangerous_goods_text,
        :insert_additional_po_text,
        :status

      def call(user_id)
        xml_parameters = params_template.result(binding)
        xml_in = template.result(binding)
        business_object = 'PORTOI'
        params = { 'UserId' => user_id,
                   'BusinessObject' => business_object,
                   'XmlParameters' => xml_parameters,
                   'XmlIn' => xml_in }
        resp = PorToi.post(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/portoi_doc.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def params_template
        ERB.new File.read(File.expand_path('schemas/portoi.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = PorToiParser.new(resp[0].data)
        parser.parse
      end

      def render_xml(inner_text)
        inner_text ? inner_text.to_s : ''
      end
    end
  end
end

