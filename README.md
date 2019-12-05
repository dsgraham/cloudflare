# Cloudflare

A Ruby client library for Cloudflare API v4.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloudflare'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloudflare

## Usage

### Zones

#### Listing zones
```ruby
zones = Cloudflare::Client.new(api_token: '[API_TOKEN]').zones.list
zones.each do |zone|
  puts zone.id
end
```
#### Get a zone by ID
```ruby
zones = Cloudflare::Client.new(api_token: '[API_TOKEN]').zones.retrieve(zone_id: '[ZONE_ID]')
```

### Firewall Rules

#### List firewall rules for a zone
```ruby
rules = Cloudflare::Client.new(api_token: '[API_TOKEN]').firewall_rules.list(zone_id: '[ZONE_ID]')
rules.each do |rule|
  puts rule.id
end
```
#### Get a firewall rule by ID
```ruby
rule = Cloudflare::Client.new(api_token: '[API_TOKEN]').firewall_rules.retrieve(zone_id: '[ZONE_ID]', id: '[RULE_ID]')
```
#### Create a firewall rule with an existing filter
```ruby
client = Cloudflare::Client.new(auth_emai: '[EMAIL]', auth_key: '[AUTH_KEY]')
rule = client.firewall_rules.create(zone_id: '[ZONE_ID]', 
                                    filter_id: '[FILTER_ID]',
                                    action: 'block',
                                    description: 'Block traffic from...')
```
#### Create a firewall rule and filter at the same time
```ruby
client = Cloudflare::Client.new(auth_emai: '[EMAIL]', auth_key: '[AUTH_KEY]')
rule = client.firewall_rules.create_with_filter(zone_id: '[ZONE_ID]', 
                                    filter_id: {description: 'Stop Russian hackers', expression: '(ip.geoip.country eq "RU")'},
                                    action: 'block',
                                    description: 'Block traffic from...')
```
#### Delete a firewall rule
```ruby
client = Cloudflare::Client.new(auth_emai: '[EMAIL]', auth_key: '[AUTH_KEY]')
client.firewall_rules.delete(zone_id: '[ZONE_ID]', id: '[RULE_ID]')
```

### Filters

#### List filters for a zone
```ruby
filters = Cloudflare::Client.new(api_token: '[API_TOKEN]').filters.list(zone_id: '[ZONE_ID]')
```
#### Get a filter by ID
```ruby
filter = = Cloudflare::Client.new(api_token: '[API_TOKEN]').filters.retrieve(zone_id: '[ZONE_ID]', id: '[FILTER_ID]')
```
#### Create a filter
```ruby
client = Cloudflare::Client.new(auth_emai: '[EMAIL]', auth_key: '[AUTH_KEY]')
filter = client.filters.create(zone_id: '[ZONE_ID]', expression: '(ip.geoip.country eq "RU")', description: 'Country is Russia')
```
#### Delete a filter
```ruby
client = Cloudflare::Client.new(auth_emai: '[EMAIL]', auth_key: '[AUTH_KEY]')
client.filters.delete(zone_id: '[ZONE_ID]', id: '[FILTER_ID]')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dsgraham/cloudflare.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
