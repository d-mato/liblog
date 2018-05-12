ActiveAdmin.register Loan do
  permit_params :started_at, :ended_at, :place_name, :book_title, :author, :isbn, :last_fetched_at, :returned
end
