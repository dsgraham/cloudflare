require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class Zones

    def initialize(base_url:, **auth_params)
      @client = Cloudflare::HttpClient.new(base_url: base_url, **auth_params)
    end

    def list(params = {})
      ResponseCursor.new(response_class: Response::Zone, endpoint: 'zones', client: @client, **params)
    end

    def retrieve(zone_id:)
      response = @client.get("zones/#{zone_id}")
      Response::Zone.new(response)
    end
  end
end