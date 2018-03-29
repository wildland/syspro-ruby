module Syspro
  class GetLogonProfile < ApiResource
    def self.get_logon_profile(user_id)
      params = { "UserId" => user_id }
      resp = self.request(:get, resource_url, params)
      parse_response(resp[0])
    end

    def resource_url
      "/GetLogonProfile"
    end

    def self.parse_response(resp)
      doc = resp.data

      UserProfile.new(
        doc.xpath("//CompanyName").text,
        doc.xpath("//OperatorCode").text,
        doc.xpath("//OperatorGroup").text,
        doc.xpath("//OperatorEmailAddress").text,
        doc.xpath("//OperatorLocation").text,
        doc.xpath("//OperatorLanguageCode").text,
        doc.xpath("//SystemLanguage").text,
        doc.xpath("//AccountingDate").text,
        doc.xpath("//CompanyDate").text,
        doc.xpath("//DefaultArBranch").text,
        doc.xpath("//DefaultApBranch").text,
        doc.xpath("//DefaultBank").text,
        doc.xpath("//DefaultWarehouse").text,
        doc.xpath("//DefaultCustomer").text,
        doc.xpath("//SystemSiteId").text,
        doc.xpath("//SystemNationalityCode").text,
        doc.xpath("//LocalCurrencyCode").text,
        doc.xpath("//CurrencyDescription").text,
        doc.xpath("//DefaultRequisitionUser").text,
        doc.xpath("//XMLToHTMLTransform").text,
        doc.xpath("//CssStyle").text,
        doc.xpath("//CssSuffix").text,
        doc.xpath("//DecimalFormat").text,
        doc.xpath("//DateFormat").text,
        doc.xpath("//FunctionalRole").text,
        doc.xpath("//DatabaseType").text,
        doc.xpath("//SysproVersion").text,
        doc.xpath("//EnetVersion").text,
        doc.xpath("//SysproServerBitWidth").text,
      )
    end
    private_class_method :parse_response

    UserProfile = Struct.new(:company_name, :operator_code, :operator_group, :operator_email_address,
                             :operator_location, :operator_language_code, :system_language, :accounting_date,
                             :company_date, :default_ar_branch, :default_ap_branch, :default_bank, :default_warehouse,
                             :default_customer, :system_site_id, :system_nationality_code, :local_currency_code,
                             :currency_description, :default_requisition_user, :xml_to_html_transform, :css_style,
                             :css_suffix, :decimal_format, :date_format, :functional_role, :database_type, :syspro_version,
                             :enet_version, :syspro_server_bit_width)
  end
end

