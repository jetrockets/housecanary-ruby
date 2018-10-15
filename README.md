# The Housecanary Ruby Gem
[![Gem Version](https://badge.fury.io/rb/housecanary-ruby.svg)](https://badge.fury.io/rb/housecanary-ruby)
[![Build Status](https://travis-ci.org/jetrockets/housecanary-ruby.svg?branch=master)](https://travis-ci.org/jetrockets/housecanary-ruby)

Ruby wrapper for the HouseCanary Data & Analytics API.
[https://www.housecanary.com/real-estate-data-api](https://www.housecanary.com/real-estate-data-api)


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'housecanary-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install housecanary-ruby

## Configuration
You can pass configuration options as a block:

```ruby
Housecanary.configure do |config|
    config.api_key = 'your_api_key'
    config.api_secret = 'your_api_secret'
end
```
## Usage
### Sales History
Search sales and ownership transfer history. [Original documentation](https://api-docs.housecanary.com/#property-sales_history).

Example:
```ruby
sales = Housecanary.properties.sales_history(address: '000 Some Street', zipcode: '01234', limit: '1')
```
If sales information is found, the `sales` will contain `Housecanary::API::SalesHistory` object.
`sales.result` will contain an array of `Housecanary::API::Sale` objects.
```ruby
=> #<Housecanary::API::SalesHistory:0x007fa0dd2f3d18
 @api_code=0,
 @api_code_description="ok",
 @result=
  [#<Housecanary::API::Sale:0x007fa0dd2f3b60
    @amount=00.0,
    @apn="000-00-0000",
    @event_type="event_type",
    @fips="11111",
    @grantee_1="Grantee1",
    @grantee_1_forenames="Grantee1forenames",
    @grantee_2=nil,
    @grantee_2_forenames=nil,
    @grantor_1="Grantor1",
    @grantor_1_forenames="Grantor1forenames",
    @grantor_2="",
    @record_book="0000",
    @record_date="1999-01-01",
    @record_doc="00000",
    @record_page="0000">]
```
## Exception Handling

If Housecanary will return anything different from 200 OK status code, `Housecanary::Error` will be raised. It contains `#message` and `#code` returned from API.

For example with invalid credentials you will receive:
``` ruby
sales = Housecanary.properties.sales_history(address: '000 Some Street', zipcode: '01234')
#=> Housecanary::Error::Unauthorized: Invalid credentials
```
Or with invalid zipcode:
```ruby
sales = Housecanary.properties.sales_history( address: '000 Sample', zipcode: '0')
#=> Housecanary::Error::BadRequest: not a valid value for dictionary value @ data[0]['zipcode']
```
## Credits

Sponsored by [JetRockets](http://www.jetrockets.pro).

![JetRockets](http://jetrockets.pro/JetRockets.jpg)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

