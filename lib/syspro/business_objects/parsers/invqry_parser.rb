# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class InvQryParser
        attr_reader :doc

        def initialize(doc)
          @calculated_weight = 0
          @doc = doc
        end

        def parse
          parsed_inv = Syspro::BusinessObjects::Models::Inv.new

          doc.xpath("//WarehouseItem").each do |wh|
            parsed_inv.addWarehouseItem({
              "warehouse": wh.xpath("Warehouse").text,
              "description": wh.xpath("Description").text,
              "qty_on_hand": wh.xpath("QtyOnHand").text,
              "available_qty": wh.xpath("AvailableQty").text,
              "qty_on_order": wh.xpath("QtyOnOrder").text,
              "qty_in_inspection": wh.xpath("QtyInInspection").text,
              "minimum_qty": wh.xpath("MinimumQty").text,
              "maximum_qty": wh.xpath("MaximumQty").text,
              "qty_on_back_order": wh.xpath("QtyOnBackOrder").text,
              "qty_allocated": wh.xpath("QtyAllocated").text,
              "mtd_qty_received": wh.xpath("MtdQtyReceived").text,
              "mtd_qty_adjusted": wh.xpath("MtdQtyAdjusted").text,
              "mtd_qty_issued": wh.xpath("MtdQtyIssued").text,
              "ytd_qty_sold": wh.xpath("YtdQtySold").text,
              "prev_year_qty_sold": wh.xpath("PrevYearQtySold").text,
              "qty_in_transit": wh.xpath("QtyInTransit").text,
              "qty_allocated_wip": wh.xpath("QtyAllocatedWip").text,
              "wip_qty_reserved": wh.xpath("WipQtyReserved").text,
              "mtd_qty_sold": wh.xpath("MtdQtySold").text,
              "mtd_qty_trf": wh.xpath("MtdQtyTrf").text,
              "user_field1": wh.xpath("UserField1").text,
              "user_field2": wh.xpath("UserField2").text,
              "user_field3": wh.xpath("UserField3").text,
              "default_bin": wh.xpath("DefaultBin").text,
              "unit_cost": wh.xpath("UnitCost").text,
              "future_free": wh.xpath("FutureFree").text,
              "quantity_dispatch_not_invoiced": wh.xpath("QuantityDispatchNotInvoiced").text
            })
          end
          
          si = doc.xpath("InvQuery/SystemInformation").first
          if si
            parsed_inv.system_information.css_style = si.xpath("CssStyle").text
            parsed_inv.system_information.language = si.xpath("Language").text
            parsed_inv.system_information.company_id = si.xpath("CompanyId").text
            parsed_inv.system_information.company_name = si.xpath("CompanyName").text
          end

          st = doc.xpath("InvQuery/StockItem").first
          if st
            parsed_inv.stock_item.stock_code = st.xpath("StockCode").text
            parsed_inv.stock_item.description = st.xpath("Description").text
            parsed_inv.stock_item.long_desc = st.xpath("LongDesc").text
          end

          wt = doc.xpath("InvQuery/WarehouseTotals").first
          if wt
            parsed_inv.warehouse_totals.qty_on_hand = wt.xpath("QtyOnHand").text
            parsed_inv.warehouse_totals.available_qty = wt.xpath("AvailableQty").text
          end

          parsed_inv
        end
      end
    end
  end
end