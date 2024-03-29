FactoryBot.define do
  factory :message do
    body { Faker::Lorem.characters(number: 30) }
    user_id { FactoryBot.create(:user).id }
    room_id { FactoryBot.create(:room).id }
  end
end
