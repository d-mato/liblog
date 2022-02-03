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

      session.visit 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'
      doc = Nokogiri.parse(session.html)

      return true if doc.text.include? 'ログインしています'

      error = doc.at('//dl/dd/font/strong')&.text&.deep_strip
      raise CannotLogInError, error
    end

    def quit
      session.quit
    end

    def fetch_loans
      loans = []
      session.visit 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'
      session.all(:xpath, '//*[@id="ContentLend"]/form/div[2]/table/tbody/tr').each do |tr|
        next if tr.all('td').size < 3 || tr.first(:xpath, 'td[3]').blank?

        loan = {
          started_at: tr.first(:xpath, 'td[7]').text.deep_strip,
          book_title: tr.first(:xpath, 'td[3]').text.deep_strip,
          place_name: tr.first(:xpath, 'td[6]').text.deep_strip,
          ended_at: tr.first(:xpath, 'td[8]').text.deep_strip
        }

        p detail_url = tr.find(:xpath, 'td[3]/a')[:href]
        session.within_window session.open_new_window do |sub_session|
          session.visit detail_url
          session.all('tr').each do |tr|
            case tr.all('th').first&.text
            when '著者'
              loan[:author] = tr.first('td').text.deep_strip
            when 'ISBN'
              loan[:isbn] = tr.first('td').text.deep_strip
            end
          end
        end

        loans << loan
      end
      loans
    end

    def extend_loan(book_title)
      session.visit 'https://www.shinagawa-lib.jp/opw/OPW/OPWUSERINFO.CSP'
      tr = session.all(:xpath, '//*[@id="ContentLend"]/form/div[2]/table/tbody/tr').find { |tr| tr.all('td')[2]&.text&.deep_strip == book_title }
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
