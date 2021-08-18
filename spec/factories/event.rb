FactoryBot.define do
  factory :event do
    name { Faker::Lorem.characters(number: 10) }
    text { Faker::Lorem.characters(number: 100) }
    store { Faker::Lorem.characters(number: 20) }
    address { Faker::Lorem.characters(number: 20) }
    start_time { Date.today }
    category_id { 1 }
    user

    trait :invalid do
      name { nil }
    end
  end
end
