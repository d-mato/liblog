module Crawler
  class ChuoCrawler < AbstractCrawler
    def login
      client.get 'https://www.library.city.chuo.tokyo.jp/login'
      form = client.page.form_with(id: 'inputForm49')
      form.field_with!(name: 'textUserId').value = @library_user.sign_in_id
      form.field_with!(name: 'textPassword').value = @library_user.password
      client.click form.button_with!(value: '入力終了')

      return true if doc.text.include? "#{@library_user.sign_in_id}さんのマイライブラリ"

      error = doc.at('//span[@class="feedbackPanelERROR"]')&.text&.strip
      raise CannotLogInError, error
    end

    private

    def _fetch_loans
      client.get 'https://www.library.city.chuo.tokyo.jp/rentallist'
      doc.xpath('//div[@class="infotable"]').map do |infotable|
        tbody = infotable.xpath('table[2]/tbody')
        date_format = '%Y年%m月%d日'
        loan = @library_user.loans.find_or_initialize_by(
          started_at: Date.strptime(tbody.xpath('tr[2]/td').text.strip, date_format),
          book_title: infotable.xpath('h3/a').text.strip
        )
        loan.place_name = tbody.xpath('tr[1]/td').text.strip
        loan.ended_at = Date.strptime(tbody.xpath('tr[4]/td').text.strip, date_format)

        detail_url = infotable.at('h3/a')[:href]
        client.get(detail_url)
        sleep 3 # getしてから3秒待つ

        client.page.parser.css('tr').each do |tr|
          case tr.at('td')&.text
          when '著者'
            loan.author = tr.at('td[2]').text.strip
          when 'ISBN'
            loan.isbn = tr.at('td[2]').text.strip
          end
        end

        loan
      end
    end
  end
end
