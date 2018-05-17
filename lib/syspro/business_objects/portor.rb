# frozen_string_literal: true

require 'syspro/business_objects/parsers/portor_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class PorTor < ApiResource
      include Syspro::ApiOperations::Transaction
      include Syspro::BusinessObjects::Parsers

      attr_accessor :transaction_date, :ignore_warnings, :non_stocked_wh_to_use, :grn_matching_action,
        :allow_blank_supplier, :apply_if_entire_document_valid, :validate_only,
        :manual_serial_transfers_allowed, :ignore_analysis

      def call(user_id)
        raise NotImplementedError.new("PORTOR not implemented yet.")
        #xml_parameters = params_template.result(binding)
        #xml_in = template.result(binding)
        #business_object = 'PORTOR'
        #params = { 'UserId' => user_id,
                   #'BusinessObject' => business_object,
                   #'XmlParameters' => xml_parameters,
                   #'XmlIn' => xml_in }
        #resp = PorTor.post(params)

        #parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/portor.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def params_template
        ERB.new File.read(File.expand_path('schemas/portor_doc.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = PorTorParser.new(resp[0].data)
        parser.parse
      end

      def handle_errors(resp)
        body = resp[0].http_body
        raise SysproError, body if body =~ /^(ERROR)/
      end
    end
  end
end

