module Syspro
  module BusinessObjects
    module Models
      class InvSwsItem
        attr_accessor :key_stock_code,
                      :key_warehouse,
                      :cost_multiplier,
                      :minimum_qty,
                      :maximum_qty,
                      :unit_cost,
                      :default_bin,
                      :safety_stock_qty,
                      :re_order_qty,
                      :pallet_qty,
                      :user_field1,
                      :user_field2,
                      :user_field3,
                      :order_policy,
                      :major_order_mult,
                      :minor_order_mult,
                      :order_minimum,
                      :order_maximum,
                      :order_fix_period,
                      :trf_supplied_item,
                      :default_source_wh,
                      :trf_lead_time,
                      :trf_cost_gl_code,
                      :trf_cost_multiply,
                      :trf_replenish_wh,
                      :trf_buying_rule,
                      :trf_dock_to_stock,
                      :trf_fix_time_period,
                      :labour_cost,
                      :material_cost,
                      :fixed_overhead,
                      :variable_overhead,
                      :sub_contract_cost,
                      :manual_cost_flag,
                      :e_signature
        end

      class InvSwsItemKey
        attr_accessor
      end
    end
  end
end
