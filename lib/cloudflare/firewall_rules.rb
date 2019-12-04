require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class FirewallRules

    def initialize(base_url:, **auth_params)
      @client = Cloudflare::HttpClient.new(base_url: base_url, **auth_params)
    end

    def list(zone_id:, **params)
      ResponseCursor.new(response_class: Response::FirewallRule, endpoint: "#{zone_id}/firewall/rules", client: @client, **params)
    end

    def retrieve(zone_id:, id:)
      response = @client.get("#{zone_id}/firewall/rules/#{id}")
      Response::FirewallRule.new(response)
    end

    def create(zone_id:, filter_id:, action:, description:)
      payload = [{filter: {id: filter_id}, action: action, description: description}]
      response = @client.post("#{zone_id}/firewall/rules", payload)
      response[:result] = response[:result]&.first # We're creating them one at a time
      Response::FirewallRule.new(response)
    end

    def create_with_filter(zone_id:, filter:, action:, description:)
      payload = [{filter: filter, action: action, description: description}]
      response = @client.post("#{zone_id}/firewall/rules", payload)
      response[:result] = response[:result]&.first # We're creating them one at a time
      Response::FirewallRule.new(response)
    end

    def delete(zone_id:, id:)
      response = @client.delete("#{zone_id}/firewall/rules/#{id}")
      Response::FirewallRule.new(response)
    end

  end
end