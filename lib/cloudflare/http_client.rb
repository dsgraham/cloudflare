require "rest-client"
require "base64"
require "cgi"
require "uri"

module Cloudflare
  class HttpClient

    def initialize(api_key, base_url)
      @headers = {'Authorization' => "Bearer #{api_key}",
                  'Content-Type' => 'application/json'}
      @base_url = base_url
    end

    def execute(method:, endpoint:, payload: {})
      headers = @headers
      headers[:params] = payload[:params] if payload.include? :params
      url = "#{@base_url}/#{endpoint}"
      request_options = {method: method, url: url, headers: headers}
      if method == :post
        payload.delete :params
        request_options[:payload] = payload.to_json
      end
      response = ::RestClient::Request.execute(request_options)
      body = JSON.parse(response, symbolize_names: true)

      unless body[:success]
        message = "Unable to #{method.to_s.upcase} to endpoint: " \
                  "#{endpoint}. #{errors}"
        raise Cloudflare::ConnectionError.new(message, self)
      end

      body
    end

    def get(endpoint, params = {})
      payload = {:params => params}
      execute(method: :get, endpoint: endpoint, payload: payload)
    end

    def post(endpoint, payload = {})
      execute(method: :post, endpoint: endpoint, payload: payload)
    end

  end
end
