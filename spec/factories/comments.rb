FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 30) }
    user
    event
  end
end
