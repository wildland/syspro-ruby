# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class ComBrwParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          next_prev_key = doc.first_element_child.xpath('NextPrevKey')
          next_prev_key_obj = next_prev_key.children.map do |el|
            next if el.name == 'text'
            {
              name: el.name,
              text: el.text
            }
          end.compact

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
                value: inner.xpath('Value').text,
                data_type: inner.xpath('DataType').text
              }
            end
          end.compact

          BrowseObject.new(
            doc.first_element_child.xpath('Title').text,
            rows_obj,
            next_prev_key_obj,
            header_details_obj
          )
        end

        BrowseObject = Struct.new(:title, :rows, :next_prev_key, :header_details)
      end
    end
  end
end
