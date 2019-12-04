module Cloudflare
  class ResponseCursor
    include Enumerable

    def initialize(response_class:, endpoint:, client:, **params)
      @response_class = response_class
      @endpoint = endpoint
      @client = client
      @params = params
      @collection = []
      @next_page = @params.delete(:page) { 1 }
      @last_page = false
    end

    def each(start = 0)
      return to_enum(:each, start) unless block_given?

      Array(@collection[start..-1]).each do |element|
        yield(element)
      end

      unless last?
        start = [@collection.size, start].max
        fetch_next_page
        each(start, &Proc.new)
      end
    end

    private

    def fetch_next_page
      response = @client.get(@endpoint, @params.merge(page: @next_page))
      @last_page = response[:result].empty? || response[:result_info][:page] == response[:result_info][:total_pages]
      results = response[:result].map{ |result| @response_class.new(result: result) }
      @collection += results
      @next_page = response[:result_info][:page] + 1 unless last?
    end

    def last?
      @last_page
    end

  end
end
