# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class SorQbs
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          binding.pry
          sor = Syspro::BusinessObjects::Models::Sor.new()
        end
      end
    end
  end
end

