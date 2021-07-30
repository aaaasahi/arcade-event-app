FactoryBot.define do
  factory :clip do
    user_id { FactoryBot.create(:user).id }
    event_id { FactoryBot.create(:event).id }
  end
end
