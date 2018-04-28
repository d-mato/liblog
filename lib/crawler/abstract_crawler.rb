module Crawler
  class AbstractCrawler
    def initialize(library_user)
      @errors = []
      @library_user = library_user
      @client = Mechanize.new
    end

    def exec
      login

      # 一旦既存の貸出を全て返却済みにする
      @library_user.loans.update_all(returned: true)

      loans = _fetch_loans
      now = Time.current
      ActiveRecord::Base.transaction do
        loans.each do |loan|
          loan.user ||= @library_user.user
          loan.attributes = { last_fetched_at: now, returned: false }
          loan.save!
        end
      end
    end

    def login
      raise NotImplementedError
    end

    private

    def _default_url
      raise NotImplementedError
    end

    # @return [Array[Loan]]
    def _fetch_loans
      raise NotImplementedError
    end
  end

  class CannotLogInError < StandardError; end
end
