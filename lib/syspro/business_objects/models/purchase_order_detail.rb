module Syspro
  module BusinessObjects
    module Models
      def PurchaseOrderDetail
        attr_accessor :purchase_order_line,
          :line_action_type,
          :stock_code,
          :stock_description,
          :warehouse,
          :sup_catalogue,
          :order_qty,
          :order_uom,
          :units,
          :pieces,
          :price_method,
          :supplier_contract,
          :price,
          :price_uom,
          :line_disc_type,
          :line_disc_less_plus,
          :line_disc_percent1,
          :line_disc_percent2,
          :line_disc_percent3,
          :line_disc_value,
          :taxable,
          :tax_codev,
          :job,
          :version,
          :release,
          :latest_due_date,
          :original_due_date,
          :reschedule_due_date,
          :ledger_code,
          :password_for_ledger_code,
          :subcontract_op,
          :inspection_reqd,
          :product_class,
          :nons_unit_mass,
          :nons_unit_vol
      end
    end
  end
end



