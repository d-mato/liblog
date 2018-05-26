module Crawler
  class KotoCrawler < AbstractCrawler
    def login
      client.get 'https://www.koto-lib.tokyo.jp/opw/OPW/OPWUSER.CSP'
      form = client.page.form_with!(name: 'usercheck')
      form.field_with!(name: 'usercardno').value = @account[:id]
      form.field_with!(name: 'userpasswd').value = @account[:password]
      client.click form.button_with!(type: 'submit')

      # JavaScriptが無効ですと言われるが、一覧ページには入れる
      client.get 'https://www.koto-lib.tokyo.jp/opw/OPW/OPWUSERINFO.CSP'

      return true if doc.text.include? "貸出カード番号:#{@account[:id]}"

      error = doc.at('//dl/dd/font/strong')&.text&.strip
      raise CannotLogInError, error
    end

    def fetch_loans
      loans = []
      client.get 'https://www.koto-lib.tokyo.jp/opw/OPW/OPWUSERINFO.CSP'
      doc.xpath('//table[2]/tr').each do |tr|
        next if tr.xpath('td[8]').blank?

        loan = {
          started_at: tr.xpath('td[7]').text.strip,
          book_title: tr.xpath('td[3]').text.strip,
          place_name: tr.xpath('td[6]').text.strip,
          ended_at: tr.xpath('td[8]').text.strip
        }

        detail_url = tr.at('td[3]/a')[:href]
        client.get(detail_url)
        sleep 3 # getしてから3秒待つ

        client.page.parser.css('tr').each do |tr|
          case tr.at('td')&.text
          when '著者'
            loan[:author] = tr.at('td[2]').text.strip
          when 'ISBN'
            loan[:isbn] = tr.at('td[2]').text.strip
          end
        end

        loans << loan
      end
      loans
    end
  end
end
