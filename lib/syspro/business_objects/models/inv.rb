module Syspro
  module BusinessObjects
    module Models
      class Inv
        attr_accessor :warehouse_totals,
                      :warehouse_items,
                      :stock_item,
                      :system_information

        def initialize
          @warehouse_totals = WarehouseTotals.new
          @warehouse_items = [] 
          @stock_item = StockItem.new
          @system_information = SystemInformation.new
        end

        def addWarehouseItem(new_hash)
          w = WarehouseItem.new

          # copy hash items that match into new warehouse item
          new_hash.keys.each do |k|
            w.send("#{k.to_s}=", new_hash[k]) if w.methods.include? k
          end

          @warehouse_items.push(w)
        end
      end

      class WarehouseTotals
        attr_accessor :qty_on_hand,
                      :available_qty
                      
        # Not all xml parsed, see https://infozone.syspro.com/Support/businessobjectslibrary/INVQRYOUT.XML
      end

      class WarehouseItem
        attr_accessor :warehouse,
                      :description,
                      :qty_on_hand,
                      :available_qty,
                      :qty_on_order,
                      :qty_in_inspection,
                      :minimum_qty,
                      :maximum_qty,
                      :qty_on_back_order,
                      :qty_allocated,
                      :mtd_qty_received,
                      :mtd_qty_adjusted,
                      :mtd_qty_issued,
                      :ytd_qty_sold,
                      :prev_year_qty_sold,
                      :qty_in_transit,
                      :qty_allocated_wip,
                      :wip_qty_reserved,
                      :mtd_qty_sold,
                      :mtd_qty_trf,
                      :user_field1,
                      :user_field2,
                      :user_field3,
                      :default_bin,
                      :unit_cost,
                      :future_free,
                      :quantity_dispatch_not_invoiced
      end

      class StockItem
        attr_accessor :stock_code,
                      :description,
                      :long_desc
        # Not all xml parsed, see https://infozone.syspro.com/Support/businessobjectslibrary/INVQRYOUT.XML
      end

      class SystemInformation
        attr_accessor :css_style,
                      :language,
                      :company_id,
                      :company_name
        # Not all xml parsed, see https://infozone.syspro.com/Support/businessobjectslibrary/INVQRYOUT.XML
      end
    end
  end
end

