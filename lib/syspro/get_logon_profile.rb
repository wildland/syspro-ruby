# frozen_string_literal: true

module Syspro
  class GetLogonProfile < ApiResource
    def self.get_logon_profile(user_id)
      params = { 'UserId' => user_id }
      resp = request(:get, resource_url, params)
      parse_response(resp[0])
    end

    def resource_url
      '/GetLogonProfile'
    end

    def self.parse_response(resp) # rubocop:disable Metrics/MethodLength
      doc = resp.data

      OpenStruct.new(
        company_name: doc.xpath('//CompanyName').text,
        operator_code: doc.xpath('//OperatorCode').text,
        operator_group: doc.xpath('//OperatorGroup').text,
        operator_email_address: doc.xpath('//OperatorEmailAddress').text,
        operator_location: doc.xpath('//OperatorLocation').text,
        operator_language_code: doc.xpath('//OperatorLanguageCode').text,
        system_language: doc.xpath('//SystemLanguage').text,
        accounting_date: doc.xpath('//AccountingDate').text,
        company_date: doc.xpath('//CompanyDate').text,
        default_ar_branch: doc.xpath('//DefaultArBranch').text,
        default_ap_branch: doc.xpath('//DefaultApBranch').text,
        default_bank: doc.xpath('//DefaultBank').text,
        default_warehouse: doc.xpath('//DefaultWarehouse').text,
        default_customer: doc.xpath('//DefaultCustomer').text,
        system_site_id: doc.xpath('//SystemSiteId').text,
        system_nationality_code: doc.xpath('//SystemNationalityCode').text,
        local_currency_code: doc.xpath('//LocalCurrencyCode').text,
        currency_description: doc.xpath('//CurrencyDescription').text,
        default_requisition_user: doc.xpath('//DefaultRequisitionUser').text,
        xml_to_html_transform: doc.xpath('//XMLToHTMLTransform').text,
        css_style: doc.xpath('//CssStyle').text,
        css_suffix: doc.xpath('//CssSuffix').text,
        decimal_format: doc.xpath('//DecimalFormat').text,
        date_format: doc.xpath('//DateFormat').text,
        functional_role: doc.xpath('//FunctionalRole').text,
        database_type: doc.xpath('//DatabaseType').text,
        syspro_version: doc.xpath('//SysproVersion').text,
        enet_version: doc.xpath('//EnetVersion').text,
        syspro_server_bit_width: doc.xpath('//SysproServerBitWidth').text
      )
    end
    private_class_method :parse_response
  end
end
