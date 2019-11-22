json.extract! @loan, :id, :started_at, :ended_at, :place_name, :book_title, :author, :isbn, :returned, :last_fetched_at
json.arrears @loan.arrears?
json.library do
  json.extract! @loan.library, :name
end
if @loan.book_review
  json.book_review do
    json.extract! @loan.book_review, :star, :comment
  end
end
