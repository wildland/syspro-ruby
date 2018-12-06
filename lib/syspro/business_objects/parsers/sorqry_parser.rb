# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class SorQryParser
        attr_reader :doc

        def initialize(doc)
          @calculated_weight = 0
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

          # Inner Nested Structure Parsing
          sor.commissions = parse_commissions(doc)
          sor.sales_order_lines = parse_sales_order_lines(doc)
          sor.ship_weight = @calculated_weight

          sor
        end

        def parse_commissions(doc)
          commissions = doc.first_element_child.xpath("Commissions")
          commissions_obj = parse_children_elements(commissions)

          commissions_obj
        end


        def parse_sales_order_lines(doc)
          sales_order_lines = doc.first_element_child.xpath("SalesOrderLine")
          sales_order_lines_obj = {}


          sales_order_lines.children.each do |el|
            next if el.name == "text"

            serial_obj = {}
            bin_obj = {}
            attached_items_obj = {}
            lot_obj = {}

            if el.name == "MiscCharge"
              unless sales_order_lines_obj[:misc_charge]
                sales_order_lines_obj[:misc_charge] = []
              end

              misc_charge_arr = parse_children_elements(el)
              sales_order_lines_obj[:misc_charge].push(misc_charge_arr)
            end

            if el.name == "Freight"
              unless sales_order_lines_obj[:freight]
                sales_order_lines_obj[:freight] = []
              end

              freight_arr = parse_children_elements(el)
              sales_order_lines_obj[:freight].push(freight_arr)
            end

            if el.name == "CommentLine"
              unless sales_order_lines_obj[:comment_line]
                sales_order_lines_obj[:comment_line] = []
              end

              comment_line_arr = parse_children_elements(el)
              sales_order_lines_obj[:comment_line].push(comment_line_arr)
            end

            if el.name == "Merchandise"
              unless sales_order_lines_obj[:merchandise]
                sales_order_lines_obj[:merchandise] = []
              end

              merchandise_arr = el.children.map do |el_child|
                next if el_child.name == "text"

                if el_child.name == "MOrderQty"
                  @calculated_weight = @calculated_weight + el_child.text.split(' ')[0].split(',').join().to_f

                  {
                    name: el_child.name,
                    text: el_child.text
                  }
                end

                # NOTE: These first three in the following
                # conditionals are "Merchandise" elements with
                # thier own nested structure that need parsed
                if el_child.name == "Serial"
                  unless serial_obj[:serial]
                    serial_obj[:serial] = []
                  end

                  serial_arr = parse_children_elements(el_child)
                  serial_obj[:serial].push(serial_arr)
                  serial_obj

                elsif el_child.name == "Bin"
                  unless bin_obj[:bin]
                    bin_obj[:bin] = []
                  end

                  bin_arr = parse_children_elements(el_child)
                  bin_obj[:bin].push(bin_arr)
                  bin_obj

                elsif el_child.name ==  "Lot"
                  unless lot_obj[:lot]
                    lot_obj[:lot] = []
                  end

                  lot_arr = parse_children_elements(el_child)
                  lot_obj[:lot].push(lot_arr)
                  lot_obj

                elsif el_child.name == "AttachedItems"
                  # NOTE: Like "Merchandise", "AttachedItems" is
                  # an element within "Merchandise" that contains
                  # elements with thier own nested structure that
                  # need parsed

                  sct_item_obj = {}
                  requisition_item_obj = {}
                  purchase_order_obj = {}

                  unless attached_items_obj[:attached_items]
                    attached_items_obj[:attached_items] = []
                  end

                  attached_items_arr = el_child.children.map do |attached_items_child|
                    next if attached_items_child.name == "text"

                    if attached_items_child.name == "SctItem"
                      unless sct_item_obj[:sct_item]
                        sct_item_obj[:sct_item] = []
                      end

                      sct_item_arr = parse_children_elements(attached_items_child)
                      sct_item_obj[:sct_item].push(sct_item_arr)
                      sct_item_obj

                    elsif attached_items_child.name == "RequisitionItem"
                      unless requisition_item_obj[:requisition_item]
                        requisition_item_obj[:requisition_item] = []
                      end

                      requisition_item_arr = parse_children_elements(attached_items_child)
                      requisition_item_obj[:requisition_item].push(requisition_item_arr)
                      requisition_item_obj

                    elsif attached_items_child.name == "PurchaseOrder"
                      unless purchase_order_obj[:purchase_order]
                        purchase_order_obj[:purchase_order] = []
                      end

                      purchase_order_arr = parse_children_elements(attached_items_child)
                      purchase_order_obj[:purchase_order].push(purchase_order_arr)
                      purchase_order_obj

                    else
                      {
                        name: attached_items_child.name,
                        text: attached_items_child.text
                      }
                    end
                  end.compact

                  attached_items_obj[:attached_items].push(attached_items_arr)
                  attached_items_obj

                else
                  {
                    name: el_child.name,
                    text: el_child.text
                  }
                end
              end.compact

              sales_order_lines_obj[:merchandise].push(merchandise_arr)
            end
          end

          sales_order_lines_obj
        end

        def parse_children_elements(el_child)
          obj_array = el_child.children.map do |el|
            next if el.name == "text"
            {
              name: el.name,
              text: el.text
            }
          end.compact

          obj_array
        end

      end
    end
  end
end
