class LibraryUser < ApplicationRecord
  belongs_to :user
  belongs_to :library

  def loans
    @loans ||= Loan.where(user: user, library: library)
  end
end
