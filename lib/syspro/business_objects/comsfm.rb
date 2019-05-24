# frozen_string_literal: true

require 'syspro/business_objects/parsers/comsfm_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class ComsFm < ApiResource
      include Syspro::ApiOperations::Setup
      include Syspro::BusinessObjects::Parsers

      attr_accessor :validate_only,
                    :items

      def add(user_id)
        xml_parameters = params_template.result(binding)
        xml_in = template.result(binding)
        business_object = 'COMSFM'
        params = { 'UserId' => user_id,
                   'BusinessObject' => business_object,
                   'XmlParameters' => xml_parameters,
                   'XmlIn' => xml_in }
        resp = ComsFm.add(params)

        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/comsfm_doc.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def params_template
        ERB.new File.read(File.expand_path('schemas/comsfm.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = ComsFmParser.new(resp[0].data)
        parser.parse
      end
    end
  end
end
