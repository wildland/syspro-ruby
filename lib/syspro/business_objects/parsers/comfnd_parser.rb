module Syspro
  module BusinessObjects
    module Parsers
      class ComFndParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          header_details = doc.first_element_child.xpath("HeaderDetails")
          header_details_obj = header_details.children.map { |el|
            if el.name == "text"
              next
            end
            {
              name: el.name,
              text: el.text
            }
          }.compact

          rows = doc.first_element_child.xpath('Row')
          rows_obj = rows.map { |el|
            el.elements.map { |inner|
              {
                name: inner.name,
                value: inner.children.text
              }
            }
          }.flatten(1).compact

          QueryObject.new(
            header_details_obj,
            rows_obj,
            doc.first_element_child.xpath('//RowsReturned').text.to_i
          )
        end

        QueryObject = Struct.new(:header_details, :rows, :row_count)
      end
    end
  end
end

