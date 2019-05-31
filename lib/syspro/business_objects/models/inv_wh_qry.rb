module Syspro
  module BusinessObjects
    module Models
      # This class stores LabbeeInvWhControl data unwrapped from
      # the Syspro XML response.
      class InvWhQry
        # This class stores warehouse data in each row
        class Warehouse
          attr_reader :warehouse, :description

          def initialize(warehouse:, description:)
            @warehouse = warehouse
            @description = description
          end
        end

        attr_reader :prev_key, :next_key, :fwd, :back, :warehouses

        def initialize(prev_key:, next_key:, fwd:, back:)
          @prev_key = prev_key
          @next_key = next_key
          @fwd = fwd
          @back = back
          @warehouses = []
        end

        def add_row(warehouse:, description:)
          @warehouses.push(
            Warehouse.new(warehouse: warehouse, description: description)
          )
        end
      end
    end
  end
end
