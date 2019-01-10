# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class PorToiParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          po = Syspro::BusinessObjects::Models::PurchaseOrder.new()
          
          po.error_numbers = doc.xpath("//ErrorNumber").map{|e| e.text}

          po.purchase_order = doc.first_element_child.xpath('Order/Key/PurchaseOrder').text
          po.item_number = doc.first_element_child.xpath('Order/ItemNumber').text
          po.order_action_type = doc.first_element_child.xpath('Order/OrderActionType').text
          po.supplier = doc.first_element_child.xpath('Order/Supplier').text
          
          po
        end

        PorToiObject = Struct.new(:key, :receipts)
      end
    end
  end
end

