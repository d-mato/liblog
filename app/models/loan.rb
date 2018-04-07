class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :library

  has_one :book_review

  validates :started_at, presence: true
  validates :ended_at, presence: true
  validates :book_title, presence: true

  # TODO
  # scope :lending, -> { where()}

  # 延滞しているか
  def arrears?
    last_fetched_at? && last_fetched_at > ended_at
  end
end
