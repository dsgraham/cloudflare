require "cloudflare/version"
require "cloudflare/zones"
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

    def initialize(api_key, base_url = 'https://api.cloudflare.com/client/v4')
      @zones = Cloudflare::Zones.new(api_key, base_url)
      @filters = Cloudflare::Filters.new(api_key, "#{base_url}/zones")
      @firewall_rules = Cloudflare::FirewallRules.new(api_key, "#{base_url}/zones")
    end

  end
end
