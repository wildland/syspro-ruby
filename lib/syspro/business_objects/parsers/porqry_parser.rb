# frozen_string_literal: true

module Syspro
  module BusinessObjects
    module Parsers
      class PorQryParser
        attr_reader :doc

        def initialize(doc)
          @doc = doc
        end

        def parse
          por = Syspro::BusinessObjects::Models::PorDetail.new()

          por.purchase_order = doc.first_element_child.xpath('PurchaseOrder').text
          por.supplier = doc.first_element_child.xpath('Supplier').text
          por.supplier_name = doc.first_element_child.xpath('SupplierName').text
          por.supplier_class = doc.first_element_child.xpath('SupplierClass').text
          por.customer = doc.first_element_child.xpath('Customer').text
          por.customer_name = doc.first_element_child.xpath('CustomerName').text
          por.customer_po_number = doc.first_element_child.xpath('CustomerPoNumber').text
          por.supplier_addr_1 = doc.first_element_child.xpath('SupplierAddr1').text
          por.supplier_addr_2 = doc.first_element_child.xpath('SupplierAddr2').text
          por.supplier_addr_3 = doc.first_element_child.xpath('SupplierAddr3').text
          por.supplier_addr_3_locality = doc.first_element_child.xpath('SupplierAddr3Locality').text
          por.supplier_addr_4 = doc.first_element_child.xpath('SupplierAddr4').text
          por.supplier_addr_5 = doc.first_element_child.xpath('SupplierAddr5').text
          por.sup_postal_code = doc.first_element_child.xpath('SupPostalCode').text
          por.currency = doc.first_element_child.xpath('Currency').text
          por.local_supplier = doc.first_element_child.xpath('LocalSupplier').text
          por.description = doc.first_element_child.xpath('Description').text
          por.delivery_name = doc.first_element_child.xpath('DeliveryName').text
          por.delivery_addr_1 = doc.first_element_child.xpath('DeliveryAddr1').text
          por.delivery_addr_2 = doc.first_element_child.xpath('DeliveryAddr2').text
          por.delivery_addr_3 = doc.first_element_child.xpath('DeliveryAddr3').text
          por.delivery_addr_3_locality = doc.first_element_child.xpath('DeliveryAddr3Locality').text
          por.delivery_addr_4 = doc.first_element_child.xpath('DeliveryAddr4').text
          por.delivery_addr_5 = doc.first_element_child.xpath('DeliveryAddr5').text
          por.postal_code = doc.first_element_child.xpath('PostalCode').text
          por.delivery_gps_lat = doc.first_element_child.xpath('DeliveryGpsLat').text
          por.delivery_gps_long = doc.first_element_child.xpath('DeliveryGpsLong').text
          por.order_status = doc.first_element_child.xpath('OrderStatus').text
          por.order_status_description = doc.first_element_child.xpath('OrderStatusDescription').text
          por.exchange_rate_fixed_flag = doc.first_element_child.xpath('ExchangeRateFixedFlag').text
          por.po_exchange_rate = doc.first_element_child.xpath('PoExchangeRate').text
          por.blanket_po_contract = doc.first_element_child.xpath('BlanketPoContract').text
          por.ap_invoice_terms = doc.first_element_child.xpath('ApInvoiceTerms').text
          por.ap_invoice_terms_description = doc.first_element_child.xpath('ApInvoiceTermsDescription').text
          por.completed_date = doc.first_element_child.xpath('CompletedDate').text
          por.warehouse = doc.first_element_child.xpath('Warehouse').text
          por.warehouse_desc
        end
      end
    end
  end
end

