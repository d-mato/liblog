FactoryBot.define do
  factory :library_user do
    user nil
    library nil
    sign_in_id "MyString"
    password "MyString"
    sign_in_count 1
    last_signed_in_at "2017-08-29 00:49:51"
  end
end
