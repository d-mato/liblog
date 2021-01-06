module Crawler
  class ShinagawaCrawler < AbstractCrawler
    def login
      client.get 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERCONF.CSP'
      form = client.page.form_with!(name: 'usercheck')
      form.field_with!(name: 'usercardno').value = @account[:id]
      form.field_with!(name: 'userpasswd').value = @account[:password]
      client.click form.button_with!(type: 'submit')

      # JavaScriptが無効ですと言われるが、一覧ページには入れる
      client.get 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'

      return true if doc.text.include? "利用券カード:#{@account[:id]}"

      error = doc.at('//dl/dd/font/strong')&.text&.strip
      raise CannotLogInError, error
    end

    def fetch_loans
      loans = []
      client.get 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'
      doc.xpath('//*[@id="ContentLend"]/form/div[2]/table/tr').each do |tr|
        next if tr.xpath('td[6]').blank?

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
          case tr.at('th')&.text
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

    def extend_loan(book_title)
      client.get 'https://www.koto-lib.tokyo.jp/opw/OPW/OPWUSERINFO.CSP'
      doc.xpath('//table[2]/tr').each do |tr|
        next unless tr.xpath('td[3]').text.strip == book_title

        form = client.page.form_with!(name: 'FormLEND')
        button_el = tr.at('td[2]/input')
        raise StandardError, '延長ボタンが見つかりません' unless button_el
        button = form.button_with!(name: button_el[:name])
        client.submit(form, button)

        form = client.page.form_with!(name: 'CheckForm')
        button = form.button_with!(name: 'chkLKOUSIN')
        client.submit(form, button)
        return true
      end

      raise StandardError, '対象の本が見つかりません'
    rescue => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      raise CannotExtendError, book_title
    end
  end
end
