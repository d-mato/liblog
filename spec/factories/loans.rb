FactoryGirl.define do
  factory :loan do
    user nil
    library nil
    started_at "2017-08-27"
    ended_at "2017-08-27"
    book_title "MyString"
    isbn "MyString"
  end
end
