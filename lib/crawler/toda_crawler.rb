module Crawler
  class TodaCrawler < AbstractCrawler
    def login
      client.get 'https://library.toda.saitama.jp/'
      form = client.page.form_with(name: 'usercheck')
      form.field_with!(name: 'usercardno').value = @library_user.sign_in_id
      form.field_with!(name: 'userpasswd').value = @library_user.password
      client.click form.button_with!(class: 'btnLogin')

      # JavaScriptが無効ですと言われるが、一覧ページには入れる
      client.get 'https://library.toda.saitama.jp/opw/OPW/OPWUSERINFO.CSP'

      return true if doc.text.include? "利用券番号:#{@library_user.sign_in_id}"

      error = doc.at('//dl/dd/font/strong')&.text&.strip
      raise CannotLogInError, error
    end

    private

    def _fetch_loans
      loans = []
      client.get 'https://library.toda.saitama.jp/opw/OPW/OPWUSERINFO.CSP'
      doc.xpath('//table[2]/tr').each do |tr|
        next if tr.xpath('td[8]').blank?

        loan = @library_user.loans.find_or_initialize_by(
          started_at: tr.xpath('td[7]').text.strip,
          book_title: tr.xpath('td[3]').text.strip
        )
        loan.place_name = tr.xpath('td[6]').text.strip
        loan.ended_at = tr.xpath('td[8]').text.strip

        loans << loan
      end
      loans
    end
  end
end
