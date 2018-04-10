# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class ComFndParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          header_details = doc.first_element_child.xpath('HeaderDetails')
          header_details_obj = header_details.children.map do |el|
            next if el.name == 'text'
            {
              name: el.name,
              text: el.text
            }
          end.compact

          rows = doc.first_element_child.xpath('Row')
          rows_obj = rows.flat_map do |el|
            el.elements.map do |inner|
              {
                name: inner.name,
                value: inner.children.text
              }
            end
          end.compact

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
