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
            "error_numbers": doc.xpath("//ErrorNumber").map{|e| e.text},
            "errors": map_errors
          }
        end

        def map_errors
          doc.xpath('//ErrorNumber/..').map do |error_parent_node|
            map_error_parent(error_parent_node)
          end
        end

        def map_error_parent(error_parent_node)
          {
            node_name: error_parent_node.name,
            error_number: error_parent_node.xpath('//ErrorNumber').text,
            error_desc: error_parent_node.xpath('//ErrorDescription').text,
            value: error_parent_node.xpath('//Value').text
          }
        end
      end
    end
  end
end

