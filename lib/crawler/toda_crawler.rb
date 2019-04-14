module Crawler
  class TodaCrawler < AbstractCrawler
    def login
      client.get 'https://library.toda.saitama.jp/opw/OPW/OPWUSERCONF.CSP?DB=LIB'
      form = client.page.form_with(name: 'usercheck')
      form.field_with!(name: 'usercardno').value = @account[:id]
      form.field_with!(name: 'userpasswd').value = @account[:password]
      client.click form.button_with!(name: 'Login')

      # JavaScriptが無効ですと言われるが、一覧ページには入れる
      client.get 'https://library.toda.saitama.jp/opw/OPW/OPWUSERINFO.CSP'

      return true if doc.text.include? "利用券番号:#{@account[:id]}"

      error = doc.at('//dl/dd/font/strong')&.text&.strip
      raise CannotLogInError, error
    end

    def fetch_loans
      loans = []
      client.get 'https://library.toda.saitama.jp/opw/OPW/OPWUSERINFO.CSP'
      doc.xpath('//table[2]/tr').each do |tr|
        next if tr.xpath('td[8]').blank?

        loan = {
          started_at: tr.xpath('td[7]').text.strip,
          book_title: tr.xpath('td[3]').text.strip,
          place_name: tr.xpath('td[6]').text.strip,
          ended_at: tr.xpath('td[8]').text.strip
        }

        loans << loan
      end
      loans
    end
  end
end
