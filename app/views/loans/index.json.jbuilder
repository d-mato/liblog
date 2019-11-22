json.array! @loans do |loan|
  json.extract! loan, :id, :started_at, :ended_at, :place_name, :book_title, :returned
  json.library do
    json.extract! loan.library, :name
  end
  if loan.book_review
    json.book_review do
      json.extract! loan.book_review, :id
    end
  end
end