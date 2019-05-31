# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class ComBrwParser
        BrowseObject = Struct.new(:headers, :rows, :next_key, :prev_key, :fwd, :back, :key)

        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          prev_key = doc.xpath('//NextPrevKey/PrevKey').text
          next_key = doc.xpath('//NextPrevKey/NextKey').text
          fwd = doc.xpath('//NextPrevKey/Fwd').text.casecmp('true').zero?
          back = doc.xpath('//NextPrevKey/Back').text.casecmp('true').zero?
          headers = doc.xpath('//HeaderDetails/Header').map { |h| h.text }
          key = doc.xpath('//HeaderDetails/Key').text

          rows = doc.xpath('//Row').map do |row|
            columns = row.children.select { |n| n.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT }
            columns.each_with_object({}) do |column, hash|
              hash[column.name] = column.children
                                        .find { |child| child.name == 'Value' }
                                        .text
            end
          end

          BrowseObject.new(
            headers,
            rows,
            next_key,
            prev_key,
            fwd,
            back,
            key
          )
        end
      end
    end
  end
end
