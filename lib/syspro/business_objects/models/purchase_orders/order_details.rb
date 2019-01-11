module Syspro
  module BusinessObjects
    module Models
      module PurchaseOrders
        class OrderDetails
          attr_accessor :stock_lines,
                        :comment_lines,
                        :misc_charge_lines,
                        :freight_lines

          def has_data
            has_stock || has_comment || has_misc_charge || has_freight
          end

          def has_stock
            (stock_lines && stock_lines.length)
          end

          def has_comment
            (comment_lines && comment_lines.length)
          end

          def has_misc_charge
            (misc_charge_lines && misc_charge_lines.length)
          end

          def has_freight
            (freight_lines && freight_lines.length)
          end
        end
      end
    end
  end
end