# syspro-ruby

syspro-ruby is an adapter gem to connect to SYSPRO 7 ERP installations. You can use this gem to connect to the SYSPRO 7 WCF Service and build Ruby applications on top of your SYSPRO data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'syspro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install syspro

## Usage

### Utilities

#### Logon

```rb
user_id = Syspro::Logon.logon(username, password, company_id, company_password)
```
`user_id` will be a `UserId` object that contains the `guid` supplied by SYSPRO. You will use this guid to make further requests to SYSPRO.

#### GetUserProfile

```rb
user_profile = Syspro::GetUserProfile.get_user_profile(guid)
```
`user_profile` will be a `UserProfile` object that contains the following:
  - `company_name`
  - `operator_code`
  - `operator_group`
  - `operator_email_address`
  - `operator_location`
  - `operator_language_code`
  - `system_language`
  - `accounting_date`
  - `company_date`
  - `default_ar_branch`
  - `default_ap_branch`
  - `default_bank`
  - `default_warehouse`
  - `default_customer`
  - `system_site_id`
  - `system_nationality_code`
  - `local_currency_code`
  - `currency_description`
  - `default_requisition_user`
  - `xml_to_html_transform`
  - `css_style`
  - `css_suffix`
  - `decimal_format`
  - `date_format`
  - `functional_role`
  - `database_type`
  - `syspro_version`
  - `enet_version`
  - `syspro_server_bit_width`

#### Logoff

```rb
logged_off = Syspro::Logoff.logoff(guid)
```
`logged_off` will be `true` if the user has been successfully logged off, and will contain an error string if an error has occured.

### Query

#### Browse
Browse returns a paginated view of a particular table.

This is an example using the generic Browse Business Object, `COMBRW`.
```rb
combrw = Syspro::BusinessObject::ComBrw.new
combrw.browse_name = "InvMaster"
combrw.start_condition = ""
combrw.return_rows = 5
combrw.filters = []
combrw.table_name = "InvMaster"
combrw.title = "StockCodes"
combrw.columns = [
  {name: "StockCode"}
]

browse_result = combrw.call(user_id.guid)
```

`browse_result` will be a BrowseObject, which has the following structure:

```rb
{
  title: "Title",
  rows: [ { name: "", value: "", data_type: "" } ],
  next_prev_key:  { name: "", text: "" },
  header_details: { name: "", text: "" }
}
```

#### Query

Query gives control over joins between multiple tables over a single Business Object.

This is an example using the generic Query Business Object, `COMFND`.

```rb
comfnd = Syspro::BusinessObjects::ComFnd.new
comfnd.table_name = "InvMaster"
comfnd.return_rows = 5
comfnd.columns = [
  {
    name: "StockCode"
  }
]
comfnd.expressions = [
  {
    andor: "And",
    column: "StockCode",
    condition: "EQ",
    value: "02"
  }
]
comfnd.order_by = "StockCode"

query_result = comfnd.call(user_id.guid)
```

This will return a QueryObject, which looks like this:

```rb
{
  header_details: { name: "", text: "" },
  rows: [ { name: "", value: "" } ],
  row_count: 1
}
```

#### Fetch

Fetch selects the `TOP 1` of the query.

This is an example using the generic Fetch Business Object, `COMFCH`.

```rb
comfch = Syspro::BusinessObjects::ComFch.new
comfch.table_name = "InvMaster"
comfch.key = "02"
comfch.optional_keys = []
comfch.full_key_provided = false
comfch.default_type = ""
comfch.espresso_fetch = true

fetch_result = comfch.call(user_id.guid)
```

This will return a FetchObject, with the following structure:

```rb
{
  table_name: "",
  columns: [ { name: "", value: "" } ]
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Run `bundle exec rake` and ensure everything looks good.

Bug reports and pull requests are welcome on GitHub at https://github.com/ike/syspro-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Syspro project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/wildland/code-of-conduct).
