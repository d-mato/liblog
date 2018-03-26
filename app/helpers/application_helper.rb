module ApplicationHelper
  def simple_datetime(datetime)
    return '' unless datetime
    current_year = Date.today.year
    datetime.strftime(datetime.year == current_year ? '%-m月%-d日' : '%Y年%-m月%-d日')
  end
end
