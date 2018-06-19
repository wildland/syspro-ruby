# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class PorTorParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          gl_journal = doc.first_element_child.xpath('GlJournal')
          gl_journal_obj = gl_journal.children.map do |el|
            next if el.name == 'text'
            {
              name: el.name,
              text: el.text
            }
          end.compact

          key = {}
          key[:jnl_year] = doc.first_element_child.xpath('JnlYear')
          key[:jnl_month] = doc.first_element_child.xpath('JnlMonth')
          key[:journal] = doc.first_element_child.xpath('Journal')
          key[:entry_number] = doc.first_element_child.xpath('EntryNumber')
          key[:warehouse] = doc.first_element_child.xpath('Warehouse')
          key[:gl_journal] = gl_journal_obj

          receipts = doc.first_element_child.xpath('Receipt')
          receipts_obj = receipts.flat_map do |el|
            el.elements.map do |inner|
              [inner.name,
              inner.value]
            end
          end.compact.to_h

          receipt_models = receipts_obj.map do |receipt|
            Por.new(
              grn: receipt.grn,
              lot_number: receipt.lot_number,
              purchase_order: receipt.purchase_order,
              purchase_order_line: receipt.purchase_order_line
            )
          end

          PorTorObject.new(
            key,
            receipt_models
          )
        end

        PorTorObject = Struct.new(:key, :receipts)
      end
    end
  end
end

