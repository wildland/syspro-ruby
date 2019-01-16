module Syspro
  module BusinessObjects
    module Models
      class ReceiptInterospection
        attr_accessor :purchase_order,
                      :warehouse,
                      :stock_code,
                      :quantity,
                      :counted_quantity_complete,
                      :delivery_note,
                      :certificate,
                      :lot
      end
    end
  end
end