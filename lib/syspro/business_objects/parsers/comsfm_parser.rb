# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class ComsFmParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          error_numbers = doc.xpath("//ErrorNumber").map{|e| e.text}
        end
      end
    end
  end
end

