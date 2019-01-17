# frozen_string_literal: true

require 'syspro/business_objects/parsers/portii_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class PorTii < ApiResource
      include Syspro::ApiOperations::Transaction
      include Syspro::BusinessObjects::Parsers

      # input params
      attr_accessor :transaction_date,
        :ignore_warnings,
        :apply_if_entire_document_valid,
        :validate_only,
        :item_inspected

      def call(user_id)
        xml_parameters = params_template.result(binding)
        xml_in = template.result(binding)
        business_object = 'PORTII'
        params = { 'UserId' => user_id,
                   'BusinessObject' => business_object,
                   'XmlParameters' => xml_parameters,
                   'XmlIn' => xml_in }
        resp = PorTii.post(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/portii_doc.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def params_template
        ERB.new File.read(File.expand_path('schemas/portii.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = PorTiiParser.new(resp[0].data)
        parser.parse
      end

      def render_xml(inner_text, dflt_value = "")
        inner_text ? inner_text.to_s : dflt_value
      end
    end
  end
end

