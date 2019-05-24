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
          doc.xpath('//ErrorNumber').map(&:text)
        end
      end
    end
  end
end
