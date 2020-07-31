module Crawler
  class ChuoCrawler < AbstractCrawler
    def login
      client.get 'https://www.library.city.chuo.tokyo.jp/login'
      form = client.page.form_with(id: 'idb')
      form.field_with!(name: 'textUserId').value = @account[:id]
      form.field_with!(name: 'textPassword').value = @account[:password]
      client.click form.button_with!(value: 'ログイン')

      return true if doc.text.include? "#{@account[:id]}さんのマイライブラリ"

      error = doc.at('//span[@class="feedbackPanelERROR"]')&.text&.strip
      raise CannotLogInError, error
    end

    def fetch_loans
      client.get 'https://www.library.city.chuo.tokyo.jp/rentallist'
      doc.xpath('//div[@class="infotable"]').map do |infotable|
        tbody = infotable.xpath('table[2]/tbody')
        date_format = '%Y年%m月%d日'
        loan = {
          started_at: Date.strptime(tbody.xpath('tr[2]/td').text.strip, date_format),
          book_title: infotable.xpath('h3/a').text.strip,
          place_name: tbody.xpath('tr[1]/td').text.strip,
          ended_at: Date.strptime(tbody.xpath('tr[4]/td').text.strip, date_format)
        }

        detail_url = infotable.at('h3/a')[:href]
        client.get(detail_url)
        sleep 3 # getしてから3秒待つ

        client.page.parser.css('tr').each do |tr|
          case tr.at('th')&.text
          when '著者'
            loan[:author] = tr.at('td').text.strip
          when 'ＩＳＢＮ'
            loan[:isbn] = tr.at('td').text.strip
          end
        end

        loan
      end
    end

    def extend_loan(book_title)
      client.get 'https://www.library.city.chuo.tokyo.jp/rentallist'
      doc.css('.infotable').each do |table|
        detail_link = table.at('h3.space a')
        next unless detail_link.text.strip == book_title

        client.get detail_link[:href]

        form = client.page.forms.first
        button = form.button_with(name: 'buttonRenew')
        raise StandardError, '延長ボタンが見つかりません' unless button
        client.submit(form, button)

        form = client.page.forms.first
        button = form.button_with!(name: 'buttonSubmit')
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
