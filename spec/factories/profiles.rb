FactoryBot.define do
  factory :profile do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 100) }
    gender { Profile.genders.keys.sample }
    age  { Faker::Date.birthday(min_age: 18, max_age: 65) }
    user
  end
end
