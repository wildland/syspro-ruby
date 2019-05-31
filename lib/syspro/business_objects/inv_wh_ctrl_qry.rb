# frozen_string_literal: true

require 'erb'

module Syspro
  module BusinessObjects
    # This class provides the ability to
    # query inventory warehouses from syspro
    class InvWhCtrlQry < ApiResource
      include Syspro::ApiOperations::Query
      include Syspro::BusinessObjects::Parsers

      attr_accessor :start_at_key, :start_condition, :return_rows,
                    :table_name, :title, :columns

      def call(user_id, raw = false)
        xml_in = template.result(binding)
        params = { 'UserId' => user_id, 'XmlIn' => xml_in }
        resp = ComBrw.browse(params)
        if raw
          resp
        else
          parse_response(resp)
        end
      end

      def template
        ERB.new(
          File.read(
            File.expand_path(
              'schemas/inv_wh_ctrl_qry.xml.erb',
              File.dirname(__FILE__)
            )
          ),
          nil,
          '%'
        )
      end

      def parse_response(resp)
        handle_errors(resp)
        parser = InvWhCtrlQryParser.new(resp[0].data)
        parser.parse
      end

      def filters
        @filters || []
      end
    end
  end
end
