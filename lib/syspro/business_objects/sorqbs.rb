# frozen_string_literal: true

require 'syspro/business_objects/parsers/sorqbs_parser'
require 'erb'

module Syspro
  module BusinessObjects
    class SorQbs < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :include_sales_order_details, :include_contact_details, :include_delivery_history,
                    :include_unconfirmed_releases, :include_confirmed_releases, :include_release_details,
                    :include_release_history, :filters

      def call(user_id)
        xml_in = template.result(binding)
        business_object = 'SORQBS'
        params = { 'UserId' => user_id, 'BusinessObject' => business_object, 'XmlIn' => xml_in }
        resp = SorQbs.query(params)
        parse_response(resp)
      end

      def template
        ERB.new File.read(File.expand_path('schemas/sorqbs.xml.erb', File.dirname(__FILE__))), nil, '%'
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = SorQbsParser.new(respo[0].data)
        parser.parse
      end

      def handle_errors(resp)
        body = resp[0].http_body
        raise SysproError, body if body =~ /^(ERROR)/
      end
    end
  end
end

