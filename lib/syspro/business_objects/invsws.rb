# frozen_string_literal: true

require 'syspro/business_objects/parsers/invsws_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class InvSws < ApiResource
      include Syspro::ApiOperations::Setup
      include Syspro::BusinessObjects::Parsers

      attr_accessor :validate_only,
                    :apply_product_class_default,
                    :ignore_warnings,
                    :apply_if_entire_document_valid,
                    :item

      def add(user_id)
        xml_parameters = params_template.result(binding)
        xml_in = template.result(binding)
        business_object = 'INVSWS'
        params = { 'UserId' => user_id,
                   'BusinessObject' => business_object,
                   'XmlParameters' => xml_parameters,
                   'XmlIn' => xml_in }
        resp = InvSws.add(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/invsws_doc.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def params_template
        ERB.new File.read(File.expand_path('schemas/invsws.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = InvSwsParser.new(resp[0].data)
        parser.parse
      end

      def render_xml(inner_text, dflt_value = '')
        inner_text ? inner_text.to_s : dflt_value
      end
    end
  end
end
