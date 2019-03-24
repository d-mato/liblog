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

    def extend_loan(book_title)
      raise NotImplementedError
    end

    private

    def client
      @client ||= Mechanize.new do |m|
        m.user_agent_alias = 'Windows Chrome'
      end
    end

    def doc
      client.page.parser
    end
  end

  class CannotLogInError < StandardError; end
  class CannotExtendError < StandardError; end
end
