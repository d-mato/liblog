module Crawler
  class AbstractCrawler
    def initialize(id: nil, password: nil)
      @account = { id: id, password: password }
    end

    def login
      raise NotImplementedError
    end

    # @return [Array[Hash]]
    def fetch_loans
      raise NotImplementedError
    end

    private

    def client
      @client ||= Mechanize.new
    end

    def doc
      client.page.parser
    end
  end

  class CannotLogInError < StandardError; end
end
