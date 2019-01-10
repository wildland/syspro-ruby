module Syspro
  module BusinessObjects
    module Models
      class PurchaseOrder
        attr_accessor :error_numbers,
                      :purchase_order,
                      :item_number,
                      :order_action_type,
                      :supplier
      end
    end
  end
end