# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class PorTiiParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          {
            error_numbers: doc.xpath("//ErrorNumber").map{|e| e.text},
            grn_numbers: doc.xpath("//Item/Key/GRNNumber").map{|e| e.text},
            items_processed: doc.xpath("//StatusOfItems/ItemsProcessed").first.text,
            items_invalid: doc.xpath("//StatusOfItems/ItemsInvalid").first.text
          }
        end

        PorToiObject = Struct.new(:key, :receipts)
      end
    end
  end
end

