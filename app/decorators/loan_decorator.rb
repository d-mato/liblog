module LoanDecorator
  def humanized_last_fetched_at
    return '' unless last_fetched_at
    "#{time_ago_in_words(last_fetched_at)}前"
  end
end
