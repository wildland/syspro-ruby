module Syspro
  module BusinessObjects
    module Models
      class SorDetail
        attr_accessor :sales_order, :document_type, :document_type_desc, :inter_branch_transfer, :inter_wh_sale,
                      :source_warehouse, :target_warehouse, :gtr_reference, :customer, :customer_name, :tax_status_code,
                      :tax_status, :gst_tax_status_code, :gst_tax_status, :eu_flag, :eu_flag_desc, :sold_to_name,
                      :sold_addr_1, :sold_addr_2, :sold_addr_3, :sold_addr_3_locality, :sold_addr_4, :sold_addr_5,
                      :sold_postal_code, :sold_gps_lat, :sold_gps_long, :salesperson, :scheduled_ord_flag, :disc_pct_1,
                      :disc_pct_2, :disc_pct_3, :salsls_name, :order_status, :order_status_desc, :customer_po_number,
                      :order_date, :git_reference, :req_ship_date, :shipping_instrs, :shipping_instrs_cod, :special_instrs,
                      :inv_terms_override, :delivery_note, :last_del_note, :time_del_prted_hh, :time_del_prted_mm, :last_invoice,
                      :date_last_inv_prt, :time_inv_prt_hh, :time_inv_prt_mm, :tblart_description, :branch, :salbrn_description,
                      :ent_invoice, :order_type, :area, :salare_description, :tax_exempt_number, :gst_exempt_number, :currency,
                      :tblcur_description, :ship_address_1, :ship_address_2, :ship_address_3, :ship_address_3_locality,
                      :ship_address_4, :ship_address_5, :ship_postal_code, :ship_gps_lat, :ship_gps_long, :ship_complete,
                      :email, :fix_exchange_rate, :exchange_rate, :edited_exchange_rate, :mul_div, :consolidated_order,
                      :gst_deduction, :credited_inv_date, :job, :serialized_flag, :counter_sales_flag, :nationality,
                      :delivery_terms, :shipping_location, :transaction_nature, :transport_mode, :process_flag,
                      :jobs_exist_flag, :alternate_key, :hierarchy_flag, :deposit_flag, :edi_source, :mult_ship_code,
                      :company_tax_no, :last_operator, :operator, :state, :county_zip, :extended_tax_code, :web_created,
                      :quote, :dispatches_made, :live_disp_exist, :num_dispatches, :include_in_mrp, :header_text,
                      :header_notes, :commissions, :sales_order_lines
      end
    end
  end
end
