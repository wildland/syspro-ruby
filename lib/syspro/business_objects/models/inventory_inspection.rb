module Syspro
  module BusinessObjects
    module Models
      class InventoryInspection
        attr_accessor :grn_number,
                      :quantity,
                      :unit_of_measure,
                      :units,
                      :pieces,
                      :document,
                      :inspection_completed
      end
    end
  end
end
