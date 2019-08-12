FactoryBot.define do
  factory :loan do
    user
    library
    started_at { Faker::Date.between(from: 14.days.ago, to: Date.today) }
    ended_at { Faker::Date.between(from: Date.tomorrow, to: 14.days.since) }
    last_fetched_at { Date.today }
    book_title { Faker::Book.title }
  end
end
