FactoryBot.define do
  factory :loan do
    user
    library
    started_at { Faker::Date.between(14.days.ago, Date.today) }
    ended_at { Faker::Date.between(Date.tomorrow, 14.days.since) }
    last_fetched_at { Date.today }
    book_title { Faker::Book.title }
  end
end
