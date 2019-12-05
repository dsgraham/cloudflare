require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class Filters

    def initialize(base_url:, **auth_params)
      @base_url = base_url
      @auth_params = auth_params
      @client = Cloudflare::HttpClient.new(base_url: base_url, **auth_params)
    end

    def list(zone_id:, **params)
      ResponseCursor.new(response_class: Response::Filter, endpoint: "#{zone_id}/filters", client: @client, **params)
    end

    def retrieve(zone_id:, id:)
      response = @client.get("#{zone_id}/filters#{id}")
      Response::Filter.new(response)
    end

    def create(zone_id:, expression:, description:)
      payload = [{expression: expression, description: description}]
      response = @client.post("#{zone_id}/filters", payload)
      response[:result] = response[:result]&.first # We're creating them one at a time
      Response::Filter.new(response)
    end

    def update(zone_id:, id:, paused:, expression:, description:)
      payload = {paused: paused, expression: expression, description: description}
      response = @client.put("#{zone_id}/filters/#{id}", payload)
      Response::Filter.new(response)
    end

    def delete(zone_id:, id:)
      response = @client.delete("#{zone_id}/filters/#{id}")
      Response::Filter.new(response)
    end

    def validate_expression(zone_id:, expression:)
      validate_url = @base_url.remove('zones')
      Cloudflare::HttpClient.new(base_url: validate_url, **@auth_params).post("/filters/validate-expr", {expression: expression})
    end

  end
end