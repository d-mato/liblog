module Crawler
  class AbstractCrawler
    def initialize(library_user)
      @errors = []
      @library_user = library_user
      @client = Faraday.new _default_url do |f|
        f.use FaradayMiddleware::FollowRedirects
        f.use :cookie_jar
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end
    end

    def exec
      unless login
        raise CannotLogInError
      end

      loans = _fetch_loans
      ActiveRecord::Base.transaction do
        loans.each(&:save!)
      end
    end

    # @return [boolean]
    def login
      raise NotImplementedError
    end

    private

    def _default_url
      raise NotImplementedError
    end

    def _login_result(body, ok:, error:)
      raise ArgumentError unless ok.is_a? Proc
      doc = Nokogiri.parse(body)
      return true if ok.call(doc)
      if error.is_a? Proc
        err = error.call(doc)
        @errors << err if err.present?
      end
      false
    end

    # @return [Array[Loan]]
    def _fetch_loans
      raise NotImplementedError
    end
  end

  class CannotLogInError < StandardError
  end
end
