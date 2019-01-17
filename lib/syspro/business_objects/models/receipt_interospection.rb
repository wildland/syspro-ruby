module Syspro
  module BusinessObjects
    module Models
      class ReceiptInterospection
        attr_accessor :purchase_order,
                      :warehouse,
                      :stock_code,
                      :quantity,
                      :counted_quantity_complete,
                      :delivery_note,
                      :certificate,
                      :lot,
                      :grn_number,
                      :concession,
                      :cost_basis,
                      :notation,
                      :reference,
                      :grn_source,
                      :bins
        def initialize
          @bins = []
        end
      end

      class InterospectionBin
        attr_accessor :bin_location,
                      :bin_quantity
      end
    end
  end
end