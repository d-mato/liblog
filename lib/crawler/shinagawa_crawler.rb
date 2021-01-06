module Crawler
  class ShinagawaCrawler < AbstractCrawler
    def session
      @session ||= Capybara::Session.new(:selenium_chrome_headless)
    end

    def login
      session.visit 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERCONF.CSP'
      session.fill_in 'usercardno', with: @account[:id]
      session.fill_in 'userpasswd', with: @account[:password]
      session.click_button 'Login'

      doc = Nokogiri.parse(session.html)

      return true if doc.text.include? "利用券カード:#{@account[:id]}"

      error = doc.at('//dl/dd/font/strong')&.text&.deep_strip
      raise CannotLogInError, error
    end

    def fetch_loans
      loans = []
      client.get 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'
      doc.xpath('//*[@id="ContentLend"]/form/div[2]/table/tr').each do |tr|
        next if tr.xpath('td[6]').blank?

        loan = {
          started_at: tr.xpath('td[7]').text.deep_strip,
          book_title: tr.xpath('td[3]').text.deep_strip,
          place_name: tr.xpath('td[6]').text.deep_strip,
          ended_at: tr.xpath('td[8]').text.deep_strip
        }

        detail_url = tr.at('td[3]/a')[:href]
        client.get(detail_url)
        sleep 3 # getしてから3秒待つ

        client.page.parser.css('tr').each do |tr|
          case tr.at('th')&.text
          when '著者'
            loan[:author] = tr.at('td[2]').text.deep_strip
          when 'ISBN'
            loan[:isbn] = tr.at('td[2]').text.deep_strip
          end
        end

        loans << loan
      end
      loans
    end

    def extend_loan(book_title)
      session.visit 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'
      tr = session.all('#ContentLend .container > table tr').find { |tr| tr.all('td')[2]&.text&.deep_strip == book_title }
      raise StandardError, '対象の本が見つかりません' unless tr

      tr.first('button[value="貸出延長"]').click
      session.first('input[name="chkLKOUSIN"]').click
      return true
    rescue => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      raise CannotExtendError, book_title
    end
  end
end
