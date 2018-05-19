json.array! @loans do |loan|
  json.extract! loan, :id, :started_at, :ended_at, :place_name, :book_title, :returned
end