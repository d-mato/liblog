class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :library

  validates :started_at, presence: true
  validates :ended_at, presence: true
  validates :book_title, presence: true

  # TODO
  # scope :lending, -> { where()}
end
