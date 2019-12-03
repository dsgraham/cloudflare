require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class Filters

    def initialize(api_key, base_url)
      @client = Cloudflare::HttpClient.new(api_key, base_url)
    end

    def list(zone_id, params = {})
      ResponseCursor.new(response_class: Response::Filter, endpoint: "#{zone_id}/filters", client: @client, **params)
    end

    def retrieve(zone_id, id)
      response = @client.get("#{zone_id}/filters#{id}")
      Response::Filter.new(response)
    end
  end
end