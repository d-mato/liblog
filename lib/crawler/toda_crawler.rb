module Crawler
  class TodaCrawler < AbstractCrawler
    def login
      params = {
        usercardno: @library_user.sign_in_id,
        userpasswd: @library_user.password,
        DB: 'LIB',
        PID: 'OPWUSER',
        MODE: 1,
        LIB: '',
        TARGET: 1
      }
      @client.post '/opw/OPW/OPWUSERLOGIN.CSP', params
      res = @client.post '/opw/OPW/OPWUSERINFO.CSP', params
      doc = Nokogiri.parse(res.body.toutf8)

      return true if doc.text.include? "利用券番号:#{@library_user.sign_in_id}"

      error = doc.at('//dl/dd/font/strong')&.text&.strip
      raise CannotLogInError, error
    end

    private

    def _default_url
      'https://library.toda.saitama.jp'
    end

    def _fetch_loans
      loans = []
      res = @client.get '/opw/OPW/OPWUSERINFO.CSP'
      doc = Nokogiri.parse(res.body.toutf8)
      doc.xpath('//table[2]/tr').each do |tr|
        next if tr.xpath('td[8]').blank?

        loans << @library_user.loans.find_or_initialize_by(
          started_at: tr.xpath('td[7]').text.strip,
          book_title: tr.xpath('td[3]').text.strip,
          place_name: tr.xpath('td[6]').text.strip,
          ended_at: tr.xpath('td[8]').text.strip
        )
      end
      loans
    end
  end
end
