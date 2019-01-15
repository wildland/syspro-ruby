module Syspro
  module BusinessObjects
    module Models
      class Inv
        attr_accessor :customer, :name, :customer_po_number, :cust_stock_code, :stock_code, :description,
                      :supply_wh, :release_manager, :release_status, :purchase_order, :shipment_days,
                      :num_day_drops, :num_week_drops, :day_in_week, :num_month_drops, :day_in_month,
                      :price_contract_num, :stock_uom, :contract_qty, :total_delivered, :total_received,
                      :opening_cume, :data_last_inv, :base_date, :expiry_date, :last_invoice, :buying_group,
                      :last_dispatch_note, :confirmed_release_details, :unconfirmed_release_details, :release_details,
                      :delivery_history_details, :release_history_details, :sor_detail, :contract_item
      end
    end
  end
end

