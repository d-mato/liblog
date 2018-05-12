class LibraryUser < ApplicationRecord
  belongs_to :user
  belongs_to :library

  has_many :loans, -> (library_user) { where(library_id: library_user.library_id) }, through: :user

  validates :sign_in_id, presence: true
  validates :password, presence: true
  validates :library_id, uniqueness: { scope: :user_id }

  # ログインした後のコールバック処理
  def call_signed_in!
    self.last_sign_in_at = Time.current
    increment(:sign_in_count)
    save!
  end
end
