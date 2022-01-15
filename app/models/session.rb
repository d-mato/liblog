class Session
  include ActiveModel::Model
  attr_accessor :email, :password

  def authenticate
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      user
    else
      errors.add(:base, 'ログインできませんでした')
      false
    end
  end
end
