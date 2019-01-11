module Syspro
  module BusinessObjects
    module Models
      module PurchaseOrders
        class MiscChargeLine
          attr_accessor :purchase_order_line,
                        :line_action_type,
                        :misc_charge_value,
                        :misc_charge_tax,
                        :misc_taxable,
                        :misc_charge_f_loc,
                        :misc_description,
                        :misc_comment_code
        end
      end
    end
  end
end