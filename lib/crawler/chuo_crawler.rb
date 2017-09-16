require 'kconv'

module Crawler
  class ChuoCrawler < AbstractCrawler
    def login
      params = {
        textUserId: @library_user.sign_in_id,
        textPassword: @library_user.password,
        inputForm49_hf_0: '',
        buttonLogin: '入力終了'
      }
      res = @client.get '/login'
      action = Nokogiri.parse(res.body.toutf8).at('//form')[:action]
      res = @client.post action, params
      _login_result(
        res.body.toutf8,
        ok: ->(doc) { doc.text.include? "#{@library_user.sign_in_id}さんのマイライブラリ" },
        error: ->(doc) { doc.at('//span[@class="feedbackPanelERROR"]').text.strip }
      )
    rescue => e
      p e
      @errors << e.message
      false
    end

    private

    def _default_url
      'https://www.library.city.chuo.tokyo.jp'
    end

    def _fetch_loans
      res = @client.get '/rentallist'
      doc = Nokogiri.parse(res.body.toutf8)
      doc.xpath('//div[@class="infotable"]').map do |infotable|
        tbody = infotable.xpath('table[2]/tbody')
        date_format = '%Y年%m月%d日'
        loan = @library_user.loans.find_or_initialize_by(
          started_at: Date.strptime(tbody.xpath('tr[2]/td').text.strip, date_format),
          book_title: infotable.xpath('h3/a').text.strip,
        )
        loan.place_name = tbody.xpath('tr[1]/td').text.strip
        loan.ended_at = Date.strptime(tbody.xpath('tr[4]/td').text.strip, date_format)
        loan
      end
    end
  end
end
