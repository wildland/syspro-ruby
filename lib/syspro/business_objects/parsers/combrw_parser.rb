module Syspro
  module BusinessObjects
    module Parsers
      class ComBrwParser

        def self.parse(doc)
          next_prev_key = doc.first_element_child.xpath("NextPrevKey")
          next_prev_key_obj = next_prev_key.children.map { |el|
            if el.name == "text"
              next
            end
            {
              name: el.name,
              text: el.text
            }
          }.compact

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
            el.elements.map { |el|
              {
                name: el.name,
                value: el.xpath('Value').text,
                data_type: el.xpath('DataType').text
              }
            }
          }.flatten(1).compact

          BrowseObject.new(
            doc.first_element_child.xpath("Title").text,
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

