# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class InvSwsParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          {
            "key": {
              "stock_code": doc.xpath("//item/key/stockcode").map{|e| e.text}.first,
              "warehouse": doc.xpath("//item/key/stockcode").map{|e| e.text}.first
            },
            "reacords_read": doc.xpath("//StatusOfItems/RecordsRead").map{|e| e.text}.first,
            "reacords_invalid": doc.xpath("//StatusOfItems/RecordsInvalid").map{|e| e.text}.first,
            "error_numbers": doc.xpath("//ErrorNumber").map{|e| e.text}
          }
        end
      end
    end
  end
end

