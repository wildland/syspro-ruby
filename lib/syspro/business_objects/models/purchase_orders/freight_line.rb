module Syspro
  module BusinessObjects
    module Models
      module PurchaseOrders
        class FreightLine
          attr_accessor :purchase_order_line,
                        :line_action_type,
                        :freight_value,
                        :freight_tax_code,
                        :freight_taxable
          :freight_f_loc
        end
      end
    end
  end
end
