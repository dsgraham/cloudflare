require "cloudflare/version"
require "cloudflare/zones"
require "cloudflare/filters"
require "cloudflare/firewall_rules"

module Cloudflare

  class ConnectionError < StandardError
    attr_reader :response
    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class Client
    attr_reader :zones, :filters, :firewall_rules

    def initialize(api_token: nil, auth_email: nil, auth_key: nil, base_url: 'https://api.cloudflare.com/client/v4')
      auth_params = {api_token: api_token, auth_email: auth_email, auth_key: auth_key}.compact
      @zones = Cloudflare::Zones.new(base_url: base_url, **auth_params)
      @filters = Cloudflare::Filters.new(base_url: "#{base_url}/zones", **auth_params)
      @firewall_rules = Cloudflare::FirewallRules.new(base_url: "#{base_url}/zones", **auth_params)
    end

  end
end
