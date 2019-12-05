require 'cloudflare/http_client'
require 'cloudflare/response'
require 'cloudflare/response_cursor'

module Cloudflare
  class DnsRecords

    def initialize(base_url:, **auth_params)
      @client = Cloudflare::HttpClient.new(base_url: base_url, **auth_params)
    end

    def list(zone_id:, **params)
      ResponseCursor.new(response_class: Response::DnsRecord, endpoint: "#{zone_id}/dns_records", client: @client, **params)
    end

    def retrieve(zone_id:, id:)
      response = @client.get("#{zone_id}/dns_records/#{id}")
      Response::DnsRecord.new(response)
    end

    def create(zone_id:, type:, name:, content:, **params)
      payload = {type: type, name: name, content: content} # required
      payload.merge!(params&.slice(:ttl, :priority, :proxied)) # optional
      response = @client.post("#{zone_id}/dns_records", payload)
      Response::DnsRecord.new(response)
    end

  end
end