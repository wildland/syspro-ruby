module Syspro
  module BusinessObjects
    module Models
      class PurchaseOrderHeader
        attr_accessor :order_action_type,
          :supplier,
          :exch_rate_fixed,
          :exchange_rate,
          :order_type,
          :customer,
          :tax_status,
          :payment_terms,
          :invoice_terms,
          :customer_po_number,
          :shipping_instrs,
          :order_date,
          :due_date,
          :memo_date,
          :apply_due_date_to_lines,
          :memo_code,
          :buyer,
          :delivery_name,
          :delivery_addr1,
          :delivery_addr2,
          :delivery_addr3,
          :delivery_addr4,
          :delivery_addr5,
          :postal_code,
          :warehouse,
          :discount_less_plus,
          :disc_percent1,
          :disc_percent2,
          :disc_percent3,
          :purchase_order,
          :chg_po_stat_to_ready_to_print
      end
    end
  end
end



