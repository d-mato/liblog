FactoryBot.define do
  factory :library do
    name { "#{Faker::Address.city}図書館" }
  end
end
