ActiveAdmin.register Loan do
  permit_params :started_at, :ended_at, :place_name, :book_title, :author, :isbn, :last_fetched_at, :returned

  controller do
    def scoped_collection
      Loan.includes(:user, :library)
    end
  end

  index do
    id_column
    column(:user) { |loan| link_to loan.user.email, [:admin, loan.user] }
    columns :book_title
    column :started_at
    column :ended_at
    column(:library) { |loan| link_to loan.library.name, [:admin, loan.library] }
    column :place_name
    column :author
    column :isbn
    column :last_fetched_at
    column :returned
    actions
  end
end
