# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class PorQryParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          por = Syspro::BusinessObjects::Models::PorDetail.new()

          por.purchase_order = doc.first_element_child.xpath('PurchaseOrder').text
          por.supplier = doc.first_element_child.xpath('Supplier').text
          por.supplier_name = doc.first_element_child.xpath('SupplierName').text
          por.supplier_class = doc.first_element_child.xpath('SupplierClass').text
          por.customer = doc.first_element_child.xpath('Customer').text
          por.customer_name = doc.first_element_child.xpath('CustomerName').text
          por.customer_po_number = doc.first_element_child.xpath('CustomerPoNumber').text
          por.supplier_addr_1 = doc.first_element_child.xpath('SupplierAddr1').text
          por.supplier_addr_2 = doc.first_element_child.xpath('SupplierAddr2').text
          por.supplier_addr_3 = doc.first_element_child.xpath('SupplierAddr3').text
          por.supplier_addr_3_locality = doc.first_element_child.xpath('SupplierAddr3Locality').text
          por.supplier_addr_4 = doc.first_element_child.xpath('SupplierAddr4').text
          por.supplier_addr_5 = doc.first_element_child.xpath('SupplierAddr5').text
          por.sup_postal_code = doc.first_element_child.xpath('SupPostalCode').text
          por.currency = doc.first_element_child.xpath('Currency').text
          por.local_supplier = doc.first_element_child.xpath('LocalSupplier').text
          por.description = doc.first_element_child.xpath('Description').text
          por.delivery_name = doc.first_element_child.xpath('DeliveryName').text
          por.delivery_addr_1 = doc.first_element_child.xpath('DeliveryAddr1').text
          por.delivery_addr_2 = doc.first_element_child.xpath('DeliveryAddr2').text
          por.delivery_addr_3 = doc.first_element_child.xpath('DeliveryAddr3').text
          por.delivery_addr_3_locality = doc.first_element_child.xpath('DeliveryAddr3Locality').text
          por.delivery_addr_4 = doc.first_element_child.xpath('DeliveryAddr4').text
          por.delivery_addr_5 = doc.first_element_child.xpath('DeliveryAddr5').text
          por.postal_code = doc.first_element_child.xpath('PostalCode').text
          por.delivery_gps_lat = doc.first_element_child.xpath('DeliveryGpsLat').text
          por.delivery_gps_long = doc.first_element_child.xpath('DeliveryGpsLong').text
          por.order_status = doc.first_element_child.xpath('OrderStatus').text
          por.order_status_description = doc.first_element_child.xpath('OrderStatusDescription').text
          por.exchange_rate_fixed_flag = doc.first_element_child.xpath('ExchangeRateFixedFlag').text
          por.po_exchange_rate = doc.first_element_child.xpath('PoExchangeRate').text
          por.blanket_po_contract = doc.first_element_child.xpath('BlanketPoContract').text
          por.ap_invoice_terms = doc.first_element_child.xpath('ApInvoiceTerms').text
          por.ap_invoice_terms_description = doc.first_element_child.xpath('ApInvoiceTermsDescription').text
          por.completed_date = doc.first_element_child.xpath('CompletedDate').text
          por.warehouse = doc.first_element_child.xpath('Warehouse').text
          por.warehouse_desc = doc.first_element_child.xpath('WarehouseDesc').text
          por.order_entry_date = doc.first_element_child.xpath('OrderEntryDate').text
          por.order_due_date = doc.first_element_child.xpath('OrderDueDate').text
          por.memo_date = doc.first_element_child.xpath('MemoDate').text
          por.memo_code = doc.first_element_child.xpath('MemoCode').text
          por.order_type = doc.first_element_child.xpath('OrderType').text
          por.payment_terms = doc.first_element_child.xpath('PaymentTerms').text
          por.tax_status = doc.first_element_child.xpath('TaxStatus').text
          por.shipping_instrs = doc.first_element_child.xpath('ShippingInstrs').text
          por.order_discount = doc.first_element_child.xpath('OrderDiscount').text
          por.amended_count = doc.first_element_child.xpath('AmendedCount').text
          por.buyer = doc.first_element_child.xpath('Buyer').text
          por.name = doc.first_element_child.xpath('Name').text
          por.document_format = doc.first_element_child.xpath('DocumentFormat').text
          por.include_in_mrp = doc.first_element_child.xpath('IncludeInMrp').text

          por.customform_fields = doc.first_element_child.xpath("CustomForm").children.select{|item| item.name === "Field"}.map do |field_el|
            if field_el && field_el.children.count > 0
              Syspro::BusinessObjects::Models::PorDetail::CustomFormField.new.tap do |field_obj|
                field_obj.sequence = field_el.children.select{|el| el.name === "Sequence"}[0].children.text
                field_obj.name = field_el.children.select{|el| el.name === "Name"}[0].children.text
                field_obj.prompt = field_el.children.select{|el| el.name === "Prompt"}[0].children.text
                field_obj.column = field_el.children.select{|el| el.name === "Column"}[0].children.text
                field_obj.type = field_el.children.select{|el| el.name === "Type"}[0].children.text
                field_obj.length = field_el.children.select{|el| el.name === "Length"}[0].children.text
                field_obj.decimals = field_el.children.select{|el| el.name === "Decimals"}[0].children.text
                field_obj.default = field_el.children.select{|el| el.name === "Default"}[0].children.text
                field_obj.allow_null = field_el.children.select{|el| el.name === "AllowNull"}[0].children.text
                field_obj.validation_type = field_el.children.select{|el| el.name === "ValidationType"}[0].children.text
                field_obj.value_null = field_el.children.select{|el| el.name === "ValueNull"}[0].children.text
              end
            end
          end.compact

          por.purchase_order_line_merchandise = doc.first_element_child.xpath("PurchaseOrderLine").children.select{|item| item.name === "Merchandise"}.map do |merch_el|
            if merch_el && merch_el.children.count > 0
              Syspro::BusinessObjects::Models::PorDetail::Merchandise.new.tap do |merch_obj|
                merch_obj.line = merch_el.children.select{|el| el.name === "Line"}[0].children.text
                merch_obj.line_type = merch_el.children.select{|el| el.name === "LineType"}[0].children.text
                merch_obj.line_Type_description = merch_el.children.select{|el| el.name === "LineTypeDescription"}[0].children.text
                merch_obj.m_stock_code = merch_el.children.select{|el| el.name === "MStockCode"}[0].children.text
                merch_obj.m_stock_des = merch_el.children.select{|el| el.name === "MStockDes"}[0].children.text
                merch_obj.long_desc = merch_el.children.select{|el| el.name === "LongDesc"}[0].children.text
                merch_obj.traceable_type = merch_el.children.select{|el| el.name === "TraceableType"}[0].children.text
                merch_obj.mass = merch_el.children.select{|el| el.name === "Mass"}[0].children.text
                merch_obj.volume = merch_el.children.select{|el| el.name === "Volume"}[0].children.text
                merch_obj.receipt_into_flag = merch_el.children.select{|el| el.name === "ReceiptIntoFlag"}[0].children.text
                merch_obj.m_warehouse = merch_el.children.select{|el| el.name === "MWarehouse"}[0].children.text
                merch_obj.m_warehouse_desc = merch_el.children.select{|el| el.name === "MWarehouseDesc"}[0].children.text
                merch_obj.m_outstanding_qty = merch_el.children.select{|el| el.name === "MOutstandingQty"}[0].children.text
                merch_obj.unedited__m_outstanding_qty = merch_el.children.select{|el| el.name === "Unedited_MOutstandingQty"}[0].children.text
                merch_obj.m_order_qty = merch_el.children.select{|el| el.name === "MOrderQty"}[0].children.text
                merch_obj.unedited__m_order_qty = merch_el.children.select{|el| el.name === "Unedited_MOrderQty"}[0].children.text
                merch_obj.m_received_qty = merch_el.children.select{|el| el.name === "MReceivedQty"}[0].children.text
                merch_obj.unedited__m_received_qty = merch_el.children.select{|el| el.name === "Unedited_MReceivedQty"}[0].children.text
                merch_obj.m_order_uom = merch_el.children.select{|el| el.name === "MOrderUom"}[0].children.text
                merch_obj.m_complete_flag = merch_el.children.select{|el| el.name === "MCompleteFlag"}[0].children.text
                merch_obj.m_job = merch_el.children.select{|el| el.name === "MJob"}[0].children.text
                merch_obj.include_in_mrp = merch_el.children.select{|el| el.name === "IncludeInMrp"}[0].children.text
                merch_obj.m_price = merch_el.children.select{|el| el.name === "MPrice"}[0].children.text
                merch_obj.edit_m_price = merch_el.children.select{|el| el.name === "Edit_MPrice"}[0].children.text
                merch_obj.order_value = merch_el.children.select{|el| el.name === "OrderValue"}[0].children.text
                merch_obj.m_disc_pct1 = merch_el.children.select{|el| el.name === "MDiscPct1"}[0].children.text
                merch_obj.m_disc_pct2 = merch_el.children.select{|el| el.name === "MDiscPct2"}[0].children.text
                merch_obj.m_disc_pct3 = merch_el.children.select{|el| el.name === "MDiscPct3"}[0].children.text
                merch_obj.m_disc_value = merch_el.children.select{|el| el.name === "MDiscValue"}[0].children.text
                merch_obj.m_disc_val_flag = merch_el.children.select{|el| el.name === "MDiscValFlag"}[0].children.text
                merch_obj.m_price_uom = merch_el.children.select{|el| el.name === "MPriceUom"}[0].children.text
                merch_obj.m_latest_due_date = merch_el.children.select{|el| el.name === "MLatestDueDate"}[0].children.text
                merch_obj.m_sup_catalogue = merch_el.children.select{|el| el.name === "MSupCatalogue"}[0].children.text
                merch_obj.m_product_class = merch_el.children.select{|el| el.name === "MProductClass"}[0].children.text
                merch_obj.m_product_class_description = merch_el.children.select{|el| el.name === "MProductClassDescription"}[0].children.text
                merch_obj.m_stocking_uom = merch_el.children.select{|el| el.name === "MStockingUom"}[0].children.text
                merch_obj.m_decimals_to_prt = merch_el.children.select{|el| el.name === "MDecimalsToPrt"}[0].children.text
                merch_obj.m_conv_fact_prc_um = merch_el.children.select{|el| el.name === "MConvFactPrcUm"}[0].children.text
                merch_obj.m_mul_div_prc = merch_el.children.select{|el| el.name === "MMulDivPrc"}[0].children.text
                merch_obj.m_tax_code = merch_el.children.select{|el| el.name === "MTaxCode"}[0].children.text
                merch_obj.m_tax_code_description = merch_el.children.select{|el| el.name === "MTaxCodeDescription"}[0].children.text
                merch_obj.m_conv_fact_ord_um = merch_el.children.select{|el| el.name === "MConvFactOrdUm"}[0].children.text
                merch_obj.m_mul_div_alloc = merch_el.children.select{|el| el.name === "MMulDivAlloc"}[0].children.text
                merch_obj.m_gl_code = merch_el.children.select{|el| el.name === "MGlCode"}[0].children.text
                merch_obj.m_gl_code_description = merch_el.children.select{|el| el.name === "MGlCodeDescription"}[0].children.text
                merch_obj.m_orig_due_date = merch_el.children.select{|el| el.name === "MOrigDueDate"}[0].children.text
                merch_obj.m_lct_confirmed = merch_el.children.select{|el| el.name === "MLctConfirmed"}[0].children.text
                merch_obj.m_subcontract_op = merch_el.children.select{|el| el.name === "MSubcontractOp"}[0].children.text
                merch_obj.m_version = merch_el.children.select{|el| el.name === "MVersion"}[0].children.text
                merch_obj.m_release = merch_el.children.select{|el| el.name === "MRelease"}[0].children.text
                merch_obj.asset_flag = merch_el.children.select{|el| el.name === "AssetFlag"}[0].children.text
                merch_obj.capex_code = merch_el.children.select{|el| el.name === "CapexCode"}[0].children.text
                merch_obj.asset_capex_line = merch_el.children.select{|el| el.name === "AssetCapexLine"}[0].children.text
                merch_obj.discount = merch_el.children.select{|el| el.name === "Discount"}[0].children.text
                merch_obj.last_receipt = merch_el.children.select{|el| el.name === "LastReceipt"}[0].children.text
                merch_obj.ledger = merch_el.children.select{|el| el.name === "Ledger"}[0].children.text
                merch_obj.requisition_line = merch_el.children.select{|el| el.name === "RequisitionLine"}[0].children.text
                merch_obj.requisition_no = merch_el.children.select{|el| el.name === "RequisitionNo"}[0].children.text
                merch_obj.requisition_user = merch_el.children.select{|el| el.name === "RequisitionUser"}[0].children.text
                merch_obj.reschedule = merch_el.children.select{|el| el.name === "Reschedule"}[0].children.text
                merch_obj.rev = merch_el.children.select{|el| el.name === "Rev"}[0].children.text
                merch_obj.release = merch_el.children.select{|el| el.name === "Release"}[0].children.text
                merch_obj.selection_code = merch_el.children.select{|el| el.name === "SelectionCode"}[0].children.text
                merch_obj.selection_type = merch_el.children.select{|el| el.name === "SelectionType"}[0].children.text
                merch_obj.currency = merch_el.children.select{|el| el.name === "Currency"}[0].children.text
                merch_obj.m_inspection_reqd = merch_el.children.select{|el| el.name === "MInspectionReqd"}[0].children.text
                merch_obj.inspected_received = merch_el.children.select{|el| el.name === "InspectedReceived"}[0].children.text
                merch_obj.stock_and_alt_um = merch_el.children.select{|el| el.name === "StockAndAltUm"}[0].children.text
                merch_obj.default_costing_method = merch_el.children.select{|el| el.name === "DefaultCostingMethod"}[0].children.text
                merch_obj.default_price = merch_el.children.select{|el| el.name === "DefaultPrice"}[0].children.text
                merch_obj.edit_default_price = merch_el.children.select{|el| el.name === "Edit_DefaultPrice"}[0].children.text
                merch_obj.default_prum = merch_el.children.select{|el| el.name === "DefaultPrum"}[0].children.text
                merch_obj.costing_methods_available = merch_el.children.select{|el| el.name === "CostingMethodsAvailable"}.map do |field_el_2|
                  if field_el_2 && field_el_2.children.count > 0
                    Syspro::BusinessObjects::Models::PorDetail::CostingMethodsAvailable.new.tap do |avail_obj|
                      avail_obj.manual_method_code = field_el_2.children.select{|el_2| el_2.name === "ManualMethodCode"}[0].children.text
                      avail_obj.manual_method_desc = field_el_2.children.select{|el_2| el_2.name === "ManualMethodDesc"}[0].children.text
                      avail_obj.manual_method_price = field_el_2.children.select{|el_2| el_2.name === "ManualMethodPrice"}[0].children.text
                      avail_obj.edit__manual_method_price = field_el_2.children.select{|el_2| el_2.name === "Edit_ManualMethodPrice"}[0].children.text
                      avail_obj.manual_method_costing_prum = field_el_2.children.select{|el_2| el_2.name === "ManualMethodCostingPrum"}[0].children.text
                      avail_obj.total_cost_method_code = field_el_2.children.select{|el_2| el_2.name === "TotalCostMethodCode"}[0].children.text
                      avail_obj.total_cost_method_desc = field_el_2.children.select{|el_2| el_2.name === "TotalCostMethodDesc"}[0].children.text
                      avail_obj.total_cost_method_price = field_el_2.children.select{|el_2| el_2.name === "TotalCostMethodPrice"}[0].children.text
                      avail_obj.edit__total_cost_method_price = field_el_2.children.select{|el_2| el_2.name === "Edit_TotalCostMethodPrice"}[0].children.text
                      avail_obj.total_cost_costing_prum = field_el_2.children.select{|el_2| el_2.name === "TotalCostCostingPrum"}[0].children.text
                      avail_obj.purchase_price_method_code = field_el_2.children.select{|el_2| el_2.name === "PurchasePriceMethodCode"}[0].children.text
                      avail_obj.purchase_price_method_desc = field_el_2.children.select{|el_2| el_2.name === "PurchasePriceMethodDesc"}[0].children.text
                      avail_obj.purchase_price_method_price = field_el_2.children.select{|el_2| el_2.name === "PurchasePriceMethodPrice"}[0].children.text
                      avail_obj.edit__purchase_price_method_price = field_el_2.children.select{|el_2| el_2.name === "Edit_PurchasePriceMethodPrice"}[0].children.text
                      avail_obj.purchase_price_costing_prum = field_el_2.children.select{|el_2| el_2.name === "PurchasePriceCostingPrum"}[0].children.text
                      avail_obj.price_tax_method_code = field_el_2.children.select{|el_2| el_2.name === "PriceTaxMethodCode"}[0].children.text
                      avail_obj.price_tax_method_desc = field_el_2.children.select{|el_2| el_2.name === "PriceTaxMethodDesc"}[0].children.text
                      avail_obj.price_tax_method_price = field_el_2.children.select{|el_2| el_2.name === "PriceTaxMethodPrice"}[0].children.text
                      avail_obj.edit__price_tax_method_price = field_el_2.children.select{|el_2| el_2.name === "Edit_PriceTaxMethodPrice"}[0].children.text
                      avail_obj.price_tax_costing_prum = field_el_2.children.select{|el_2| el_2.name === "PriceTaxCostingPrum"}[0].children.text
                    end
                  end
                end.compact
              end
            end
          end.compact

          por.purchase_order_totals = doc.first_element_child.xpath("PurchaseOrderTotals").map do |total_el|
            Syspro::BusinessObjects::Models::PorDetail::PurchaseOrderTotals.new.tap do |total_obj|

              total_obj.local_values = total_el.children.select{|el| el.name === "LocalValues"}.map do |loc_val_el|
                Syspro::BusinessObjects::Models::PorDetail::PurchaseOrderTotalsLocalValues.new.tap do |loc_obj|
                  loc_obj.local_order_value = loc_val_el.children.select{|el_2| el_2.name === "LocalOrderValue"}[0].text
                  loc_obj.local_received_to_date_value = loc_val_el.children.select{|el_2| el_2.name === "LocalReceivedToDateValue"}[0].text
                  loc_obj.local_outstanding_value = loc_val_el.children.select{|el_2| el_2.name === "LocalOutstandingValue"}[0].text
                  loc_obj.edited_local_order_value = loc_val_el.children.select{|el_2| el_2.name === "Edited_LocalOrderValue"}[0].text
                  loc_obj.edited_local_received_to_date_value = loc_val_el.children.select{|el_2| el_2.name === "Edited_LocalReceivedToDateValue"}[0].text
                  loc_obj.edited_local_outstanding_value = loc_val_el.children.select{|el_2| el_2.name === "Edited_LocalOutstandingValue"}[0].text
                end
              end

              total_obj.current_values = total_el.children.select{|el| el.name === "CurrentValues"}.map do |cur_val_el|
                Syspro::BusinessObjects::Models::PorDetail::PurchaseOrderTotalsCurrentValues.new.tap do |cur_obj|
                  cur_obj.current_order_value = cur_val_el.children.select{|el_2| el_2.name === "CurrentOrderValue"}[0].text
                  cur_obj.current_received_to_date_value = cur_val_el.children.select{|el_2| el_2.name === "CurrentReceivedToDateValue"}[0].text
                  cur_obj.current_outstanding_value = cur_val_el.children.select{|el_2| el_2.name === "CurrentOutstandingValue"}[0].text
                  cur_obj.edited_current_order_value = cur_val_el.children.select{|el_2| el_2.name === "Edited_CurrentOrderValue"}[0].text
                  cur_obj.edited_current_received_to_date_value = cur_val_el.children.select{|el_2| el_2.name === "Edited_CurrentReceivedToDateValue"}[0].text
                  cur_obj.edited_current_outstanding_value = cur_val_el.children.select{|el_2| el_2.name === "Edited_CurrentOutstandingValue"}[0].text
                end
              end

              total_obj.first_receipt_date = total_el.children.select{|el| el.name === "FirstReceiptDate"}[0].text
              total_obj.order_complete_date = total_el.children.select{|el| el.name === "OrderCompleteDate"}[0].text
            end
          end.compact

          por
        end
      end
    end
  end
end
