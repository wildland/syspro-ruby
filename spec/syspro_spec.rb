RSpec.describe Syspro do
  server_name = "dev3"

  Rspec.describe PrimitiveClient do
    base_url = "http://#{server_name}/SYSPROWCFService"
    binding = "RESTHttp"

    it "has a version number" do
      expect(Syspro::VERSION).not_to be nil
    end

    it "does something useful" do
      expect(false).to eq(true)
    end

    it "can be instantiated" do
      expect {
        sys = Syspro::PrimitiveClient.new(base_url, binding)
      }.not_to raise_error
    end

    it "can login to a syspro database" do
      sys = Syspro::PrimitiveClient.new(base_url, binding)
      login_reply = sys.login(operator_name, password, company_id, company_password)

      expect(login_reply).to eq(login_reply_example)
    end

    it "can logoff from a syspro database" do
      sys = Syspro::PrimitiveClient.new(base_url, binding)
      logoff_reply = sys.logoff(user_id)

      expect(logoff_reply).to eq(logoff_reply_example)
    end

    Rspec.describe Query do
      sys = Syspro::PrimitiveClient.new(base_url, binding)

      it "can query browse" do
        query_result = sys.query_browse(user_id, query_object)

        expect(query_result).to eq(query_result_example)
      end

      it "can query fetch" do
        query_result = sys.query_fetch(user_id, query_object)

        expect(query_result).to eq(query_result_example)
      end

      it "can query query" do
        query_result = sys.query_query(user_id, business_object, query_object)

        expect(query_result).to eq(query_result_example)
      end
    end

    Rspec.describe Setup do
      sys = Syspro::PrimitiveClient.new(base_url, binding)

      it "can add" do
        setup_result = sys.setup_add(user_id, business_object, params, query_object)

        expect(setup_result).to eq(setup_result_example)
      end

      it "can delete" do
        setup_result = sys.setup_delete(user_id, business_object, params, query_object)

        expect(setup_result).to eq(setup_result_example)
      end

      it "can update" do
        setup_result = sys.setup_update(user_id, business_object, params, query_object)

        expect(setup_result).to eq(setup_result_example)
      end
    end

    Rspec.describe Transaction do
      sys = Syspro::PrimitiveClient.new(base_url, binding)

      it "can build" do
        expect(sys.transaction_build(user_id, business_object, query_object)).to eq(transaction_result_example)
      end

      it "can post" do
        expect(sys.transaction_post(user_id, business_object, query_object)).to eq(transaction_result_example)
      end
    end

    Rspec.describe Asynchronous do
      # TODO: Describe asynchronous versions of above methods
    end

  end # Primitive

  Rpec.describe Client do
    base_url = "http://#{server_name}/SYSPROWCFService"
    binding = "RESTHttp"

    Rspec.describe Utilities do

    end

    Rspec.describe Query do
    end

    Rspec.describe Setup do
    end

    Rspec.describe Transaction do
    end
  end # Client
end

