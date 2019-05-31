# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class InvWhCtrlQryParser
        attr_reader :doc

        def initialize(doc)
          @calculated_weight = 0
          @doc = doc
        end

        def parse
          inv_wh_qry = Syspro::BusinessObjects::Models::InvWhQry.new(
            prev_key: doc.xpath('//NextPrevKey/PrevKey').text,
            next_key: doc.xpath('//NextPrevKey/NextKey').text,
            fwd: doc.xpath('//NextPrevKey/Fwd').text.casecmp('true').zero?,
            back: doc.xpath('//NextPrevKey/Back').text.casecmp('true').zero?
          )

          doc.xpath('//Row').each do |wh|
            inv_wh_qry.add_row(
              "warehouse": wh.xpath('Warehouse/Value').text,
              "description": wh.xpath('Description/Value').text
            )
          end

          inv_wh_qry
        end
      end
    end
  end
end
