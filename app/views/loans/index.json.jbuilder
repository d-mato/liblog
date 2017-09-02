json.array! @loans do |loan|
  json.extract! loan, :started_at, :ended_at, :place_name, :book_title
end