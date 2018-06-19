module Syspro
  module BusinessObjects
    module Models
      class PorDetail
        attr_accessor :grn, :lot_number, :purchase_order, :purchase_order_line, :supplier, :supplier_name,
                      :supplier_class, :customer, :customer_name, :customer_po_number, :warehouse, :warehouse_desc,
                      :supplier_addr_1, :supplier_addr_2, :supplier_addr_3, :supplier_addr_3_locality,
                      :supplier_addr_4, :supplier_addr_5, :sup_postal_code, :currency, :local_supplier,
                      :description, :delivery_name, :delivery_addr_1, :delivery_addr_2, :delivery_addr_3,
                      :delivery_addr_3_locality, :delivery_addr_4, :delivery_addr_5, :postal_code, :delivery_gps_lat,
                      :delivery_gps_long, :order_status, :order_status_description, :exchange_rate_fixed_flag,
                      :po_exchange_rate, :blanket_po_contract, :ap_invoice_terms, :ap_invoice_terms_description,
                      :completed_date, :order_entry_date, :order_due_date, :memo_date, :memo_code, :order_type,
                      :payment_terms, :tax_status, :shipping_instrs, :order_discount, :amended_count, :buyer, :name,
                      :document_format, :include_in_mrp, :customform_fields, :purchase_order_line_merchandise,
                      :purchase_order_totals

        class CustomFormField
          attr_accessor :sequence, :name, :prompt, :column, :type, :length, :decimals, :default, :allow_null,
                        :validation_type, :value_null
        end

        class Merchandise
          attr_accessor :line,
                        :line_type,
                        :line_Type_description,
                        :m_stock_code,
                        :m_stock_des,
                        :long_desc,
                        :traceable_type,
                        :mass,
                        :volume,
                        :receipt_into_flag,
                        :m_warehouse,
                        :m_warehouse_desc,
                        :m_outstanding_qty,
                        :unedited__m_outstanding_qty,
                        :m_order_qty,
                        :unedited__m_order_qty,
                        :m_received_qty,
                        :unedited__m_received_qty,
                        :m_order_uom,
                        :m_complete_flag,
                        :m_job,
                        :include_in_mrp,
                        :m_price,
                        :edit_m_price,
                        :order_value,
                        :m_disc_pct1,
                        :m_disc_pct2,
                        :m_disc_pct3,
                        :m_disc_value,
                        :m_disc_val_flag,
                        :m_price_uom,
                        :m_latest_due_date,
                        :m_sup_catalogue,
                        :m_product_class,
                        :m_product_class_description,
                        :m_stocking_uom,
                        :m_decimals_to_prt,
                        :m_conv_fact_prc_um,
                        :m_mul_div_prc,
                        :m_tax_code,
                        :m_tax_code_description,
                        :m_conv_fact_ord_um,
                        :m_mul_div_alloc,
                        :m_gl_code,
                        :m_gl_code_description,
                        :m_orig_due_date,
                        :m_lct_confirmed,
                        :m_subcontract_op,
                        :m_version,
                        :m_release,
                        :asset_flag,
                        :capex_code,
                        :asset_capex_line,
                        :discount,
                        :last_receipt,
                        :ledger,
                        :requisition_line,
                        :requisition_no,
                        :requisition_user,
                        :reschedule,
                        :rev,
                        :release,
                        :selection_code,
                        :selection_type,
                        :currency,
                        :m_inspection_reqd,
                        :inspected_received,
                        :stock_and_alt_um,
                        :default_costing_method,
                        :default_price,
                        :edit_default_price,
                        :default_prum,
                        :costing_methods_available

        end # end of class MerchandiseDetail

        class CostingMethodsAvailable
          attr_accessor :manual_method_code,
            :manual_method_desc,
            :manual_method_price,
            :edit__manual_method_price,
            :manual_method_costing_prum,
            :total_cost_method_code,
            :total_cost_method_desc,
            :total_cost_method_price,
            :edit__total_cost_method_price,
            :total_cost_costing_prum,
            :purchase_price_method_code,
            :purchase_price_method_desc,
            :purchase_price_method_price,
            :edit__purchase_price_method_price,
            :purchase_price_costing_prum,
            :price_tax_method_code,
            :price_tax_method_desc,
            :price_tax_method_price,
            :edit__price_tax_method_price,
            :price_tax_costing_prum
        end # end of class CostingMethodsAvailable

        class PurchaseOrderTotals
          attr_accessor :local_values, :current_values, :first_receipt_date, :order_complete_date

        end

        class PurchaseOrderTotalsLocalValues
          attr_accessor :local_order_value, :local_received_to_date_value, :local_outstanding_value,
                        :edited_local_order_value, :edited_local_received_to_date_value,
                        :edited_local_outstanding_value
        end

        class PurchaseOrderTotalsCurrentValues
          attr_accessor :current_order_value, :current_received_to_date_value, :current_outstanding_value,
                        :edited_current_order_value, :edited_current_received_to_date_value,
                        :edited_current_outstanding_value
        end

      end
    end
  end
end
