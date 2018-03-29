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

#### GetLogonProfile

```rb
user_profile = Syspro::GetLogonProfile.get_logon_profile(guid)
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ike/syspro-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Syspro project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ike/syspro-ruby/blob/master/CODE_OF_CONDUCT.md).
