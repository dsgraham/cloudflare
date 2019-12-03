require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class Zones

    def initialize(api_key, base_url)
      @client = Cloudflare::HttpClient.new(api_key, base_url)
    end

    def list(params = {})
      ResponseCursor.new(response_class: Response::Zone, endpoint: 'zones', client: @client, **params)
    end

    def retrieve(zone_id)
      response = @client.get("zones/#{zone_id}")
      Response::Zone.new(response)
    end
  end
end