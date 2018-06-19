# frozen_string_literal: true

require 'syspro/business_objects/parsers/comfnd_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class ComFnd < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :table_name, :return_rows, :columns, :expressions,
                    :order_by

      def call(user_id)
        xml_in = template.result(binding)
        business_object = 'COMFND'
        params = { 'UserId' => user_id, 'BusinessObject' => business_object, 'XmlIn' => xml_in }
        resp = ComFnd.query(params)
        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/comfnd.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = ComFndParser.new(resp[0].data)
        parser.parse
      end
    end
  end
end
