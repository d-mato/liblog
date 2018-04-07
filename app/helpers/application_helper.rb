module ApplicationHelper
  def simple_date(datetime)
    return '' unless datetime.respond_to? :strftime
    current_year = Date.today.year
    datetime.strftime(datetime.year == current_year ? '%-m月%-d日' : '%Y年%-m月%-d日')
  end
end
