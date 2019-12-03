require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class FirewallRules

    def initialize(api_key, base_url)
      @client = Cloudflare::HttpClient.new(api_key, base_url)
    end

    def list(zone_id, params = {})
      ResponseCursor.new(response_class: Response::FirewallRule, endpoint: "#{zone_id}/firewall/rules", client: @client, **params)
    end

    def retrieve(zone_id, id)
      response = @client.get("#{zone_id}/firewall/rules/#{id}")
      Response::FirewallRule.new(response)
    end
  end
end