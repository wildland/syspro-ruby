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
          
        end
      end
    end
  end
end