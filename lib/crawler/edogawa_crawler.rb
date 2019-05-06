module Crawler
  class EdogawaCrawler < AbstractCrawler
    def login
      client.get 'https://www.library.city.edogawa.tokyo.jp/toshow/asp/WwPortLogin.aspx'
      form = client.page.form_with(id: 'Form1')
      form.field_with!(name: 'txtRiyoshaCD').value = @account[:id]
      form.field_with!(name: 'txtPassWord').value = @account[:password]
      client.click form.button_with!(value: 'ログイン')

      return true if doc.text.include? " ( #{@account[:id]} ) さん"

      error = doc.at('#lblErrMsg')&.text&.strip
      raise CannotLogInError, error
    end

    def fetch_loans
      client.get 'https://www.library.city.edogawa.tokyo.jp/toshow/asp/WwPortTop.aspx'

      form = client.page.form_with(id: 'Form1')
      client.click form.button_with!(value: '借りている・予約している資料')

      form = client.page.form_with(id: 'Form1')
      doc.css('table#dgdKas tr:not(.list_Header)').map do |tr|
        target = tr.at('a')[:href].to_s[/'(.+?)'/, 1]
        form.field_with!(name: '__EVENTTARGET').value = target
        form.submit

        loan = {
          started_at: Date.parse(doc.at('#lblKasDate').text),
          book_title: doc.at("//div[@class='list_syo']/text()").text.strip,
          author: doc.at("//div[@class='list_cyo']/text()")&.text.to_s.strip,
          place_name: doc.at('#lblKasBasho').text.strip,
          ended_at: Date.parse(doc.at('#lblHenDate').text)
        }

        doc.css('#dgdShousai tr').each do |tr|
          case tr.at('td.Shousa_Name')&.text.to_s.strip
          when 'ＩＳＢＮ'
            loan[:isbn] = tr.at('td.Shousa_Data').text.to_s[/[\d\-]+/, 0]
          end
        end

        loan
      end
    end

    # def extend_loan(book_title)
    #   client.get 'https://www.library.city.chuo.tokyo.jp/rentallist'
    #   doc.css('.infotable').each do |table|
    #     detail_link = table.at('h3.space a')
    #     next unless detail_link.text.strip == book_title
    #
    #     client.get detail_link[:href]
    #
    #     form = client.page.forms.first
    #     button = form.button_with(name: 'buttonRenew')
    #     raise StandardError, '延長ボタンが見つかりません' unless button
    #     client.submit(form, button)
    #
    #     form = client.page.forms.first
    #     button = form.button_with!(name: 'buttonSubmit')
    #     client.submit(form, button)
    #
    #     return true
    #   end
    #
    #   raise StandardError, '対象の本が見つかりません'
    # rescue => e
    #   Rails.logger.error e.message
    #   Rails.logger.error e.backtrace.join("\n")
    #   raise CannotExtendError, book_title
    # end
  end
end
