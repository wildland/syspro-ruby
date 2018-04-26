# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class SorQryParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          sor = Syspro::BusinessObjects::Models::SorDetail.new()
          sor.sales_order = doc.first_element_child.xpath("SalesOrder").text
          sor.document_type = doc.first_element_child.xpath("DocumentType").text
          sor.document_type_desc = doc.first_element_child.xpath("DocumentTypeDesc").text
          sor.inter_branch_transfer = doc.first_element_child.xpath("InterBranchTransfer").text
          sor.inter_wh_sale = doc.first_element_child.xpath("InterWhSale").text
          sor.source_warehouse = doc.first_element_child.xpath("SourceWarehouse").text
          sor.target_warehouse = doc.first_element_child.xpath("TargetWarehouse").text
          sor.gtr_reference = doc.first_element_child.xpath("GtrReference").text
          sor.customer = doc.first_element_child.xpath("Customer").text
          sor.customer_name = doc.first_element_child.xpath("CustomerName").text
          sor.tax_status_code = doc.first_element_child.xpath("TaxStatusCode").text
          sor.tax_status = doc.first_element_child.xpath("TaxStatus").text
          sor.gst_tax_status_code = doc.first_element_child.xpath("GstTaxStatusCode").text
          sor.gst_tax_status = doc.first_element_child.xpath("GstTaxStatus").text
          sor.eu_flag = doc.first_element_child.xpath("EuFlag").text
          sor.eu_flag_desc = doc.first_element_child.xpath("EuFlagDesc").text
          sor.sold_to_name = doc.first_element_child.xpath("SoldToName").text
          sor.sold_addr_1 = doc.first_element_child.xpath("SoldAddr1").text
          sor.sold_addr_2 = doc.first_element_child.xpath("SoldAddr2").text
          sor.sold_addr_3 = doc.first_element_child.xpath("SoldAddr3").text
          sor.sold_addr_3_locality = doc.first_element_child.xpath("SoldAddr3Locality").text
          sor.sold_addr_4 = doc.first_element_child.xpath("SoldAddr4").text
          sor.sold_addr_5 = doc.first_element_child.xpath("SoldAddr5").text
          sor.sold_postal_code = doc.first_element_child.xpath("SoldPostalCode").text
          sor.sold_gps_lat = doc.first_element_child.xpath("SoldGpsLat").text
          sor.sold_gps_long = doc.first_element_child.xpath("SoldGpsLong").text
          sor.salesperson = doc.first_element_child.xpath("Salesperson").text
          sor.scheduled_ord_flag = doc.first_element_child.xpath("ScheduledOrdFlag").text
          sor.disc_pct_1 = doc.first_element_child.xpath("DiscPct1").text
          sor.disc_pct_2 = doc.first_element_child.xpath("DiscPct2").text
          sor.disc_pct_3 = doc.first_element_child.xpath("DiscPct3").text
          sor.salsls_name = doc.first_element_child.at_xpath('//SALSLS:Name').children.text
          sor.order_status = doc.first_element_child.xpath("OrderStatus").text
          sor.order_status_desc = doc.first_element_child.xpath("OrderStatusDesc").text
          sor.customer_po_number = doc.first_element_child.xpath("CustomerPoNumber").text
          sor.order_date = doc.first_element_child.xpath("OrderDate").text
          sor.git_reference = doc.first_element_child.xpath("GITReference").text
          sor.req_ship_date = doc.first_element_child.xpath("ReqShipDate").text
          sor.shipping_instrs = doc.first_element_child.xpath("ShippingInstrs").text
          sor.shipping_instrs_cod = doc.first_element_child.xpath("ShippingInstrsCod").text
          sor.special_instrs = doc.first_element_child.xpath("SpecialInstrs").text
          sor.inv_terms_override = doc.first_element_child.xpath("InvTermsOverride").text
          sor.delivery_note = doc.first_element_child.xpath("DeliveryNote").text
          sor.last_del_note = doc.first_element_child.xpath("LastDelNote").text
          sor.time_del_prted_hh = doc.first_element_child.xpath("TimeDelPrtedHh").text
          sor.time_del_prted_mm = doc.first_element_child.xpath("TimeDelPrtedMm").text
          sor.last_invoice = doc.first_element_child.xpath("LastInvoice").text
          sor.date_last_inv_prt = doc.first_element_child.xpath("DateLastInvPrt").text
          sor.time_inv_prt_hh = doc.first_element_child.xpath("TimeInvPrtHh").text
          sor.time_inv_prt_mm = doc.first_element_child.xpath("TimeInvPrtMm").text
          sor.tblart_description = doc.first_element_child.xpath("//TBLART:Description").children.text
          sor.branch = doc.first_element_child.xpath("Branch").text
          sor.salbrn_description = doc.first_element_child.xpath("//SALBRN:Description").children.text
          sor.ent_invoice = doc.first_element_child.xpath("EntInvoice").text
          sor.order_type = doc.first_element_child.xpath("OrderType").text
          sor.area = doc.first_element_child.xpath("Area").text
          sor.salare_description = doc.first_element_child.xpath("//SALARE:Description").children.text
          sor.tax_exempt_number = doc.first_element_child.xpath("TaxExemptNumber").text
          sor.gst_exempt_number = doc.first_element_child.xpath("GstExemptNumber").text
          sor.currency = doc.first_element_child.xpath("Currency").text
          sor.tblcur_description = doc.first_element_child.xpath("//TBLCUR:Description").children.text
          sor.ship_address_1 = doc.first_element_child.xpath("ShipAddress1").text
          sor.ship_address_2 = doc.first_element_child.xpath("ShipAddress2").text
          sor.ship_address_3 = doc.first_element_child.xpath("ShipAddress3").text
          sor.ship_address_3_locality = doc.first_element_child.xpath("ShipAddress3Locality").text
          sor.ship_address_4 = doc.first_element_child.xpath("ShipAddress4").text
          sor.ship_address_5 = doc.first_element_child.xpath("ShipAddress5").text
          sor.ship_postal_code = doc.first_element_child.xpath("ShipPostalCode").text
          sor.ship_gps_lat = doc.first_element_child.xpath("ShipGpsLat").text
          sor.ship_gps_long = doc.first_element_child.xpath("ShipGpsLong").text
          sor.ship_complete = doc.first_element_child.xpath("ShipComplete").text
          sor.email = doc.first_element_child.xpath("Email").text
          sor.fix_exchange_rate = doc.first_element_child.xpath("FixExchangeRate").text
          sor.exchange_rate = doc.first_element_child.xpath("ExchangeRate").text
          sor.edited_exchange_rate = doc.first_element_child.xpath("EditedExchangeRate").text
          sor.mul_div = doc.first_element_child.xpath("MulDiv").text
          sor.consolidated_order = doc.first_element_child.xpath("ConsolidatedOrder").text
          sor.gst_deduction = doc.first_element_child.xpath("GstDeduction").text
          sor.credited_inv_date = doc.first_element_child.xpath("CreditedInvDate").text
          sor.job = doc.first_element_child.xpath("Job").text
          sor.serialized_flag = doc.first_element_child.xpath("SerializedFlag").text
          sor.counter_sales_flag = doc.first_element_child.xpath("CounterSalesFlag").text
          sor.nationality = doc.first_element_child.xpath("Nationality").text
          sor.delivery_terms = doc.first_element_child.xpath("DeliveryTerms").text
          sor.shipping_location = doc.first_element_child.xpath("ShippingLocation").text
          sor.transaction_nature = doc.first_element_child.xpath("TransactionNature").text
          sor.transport_mode = doc.first_element_child.xpath("TransportMode").text
          sor.process_flag = doc.first_element_child.xpath("ProcessFlag").text
          sor.jobs_exist_flag = doc.first_element_child.xpath("JobsExistFlag").text
          sor.alternate_key = doc.first_element_child.xpath("AlternateKey").text
          sor.hierarchy_flag = doc.first_element_child.xpath("HierarchyFlag").text
          sor.deposit_flag = doc.first_element_child.xpath("DepositFlag").text
          sor.edi_source = doc.first_element_child.xpath("EdiSource").text
          sor.mult_ship_code = doc.first_element_child.xpath("MultShipCode").text
          sor.company_tax_no = doc.first_element_child.xpath("CompanyTaxNo").text
          sor.last_operator = doc.first_element_child.xpath("LastOperator").text
          sor.operator = doc.first_element_child.xpath("Operator").text
          sor.state = doc.first_element_child.xpath("State").text
          sor.county_zip = doc.first_element_child.xpath("CountyZip").text
          sor.extended_tax_code = doc.first_element_child.xpath("ExtendedTaxCode").text
          sor.web_created = doc.first_element_child.xpath("WebCreated").text
          sor.quote = doc.first_element_child.xpath("Quote").text
          sor.dispatches_made = doc.first_element_child.xpath("DispatchesMade").text
          sor.live_disp_exist = doc.first_element_child.xpath("LiveDispExist").text
          sor.num_dispatches = doc.first_element_child.xpath("NumDispatches").text
          sor.include_in_mrp = doc.first_element_child.xpath("IncludeInMrp").text
          sor.header_text = doc.first_element_child.xpath("HeaderText").text
          sor.header_notes = doc.first_element_child.xpath("HeaderNotes").text

          commissions = doc.first_element_child.xpath("Commissions")
          commissions_obj = commissions.children.map do |el|
            next if el.name == "text"
            {
              name: el.name,
              text: el.text
            }
          end.compact
          sor.commissions = commissions_obj

          sor
        end
      end
    end
  end
end

