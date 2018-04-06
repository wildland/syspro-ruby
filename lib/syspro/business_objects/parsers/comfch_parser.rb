module Syspro
  module BusinessObjects
    module Parsers
      class ComFchParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          table_name = doc.first_element_child.name
          columns = doc.first_element_child.elements
          columns_obj = columns.map { |el|
            { name: el.name, value: el.children.text }
          }.compact

          FetchObject.new(
            table_name,
            columns_obj
          )
        end

        FetchObject = Struct.new(:table_name, :columns)
      end
    end
  end
end

