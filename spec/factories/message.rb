FactoryBot.define do
  factory :message do
    association :user
    association :conversation
    body { Faker::Quote.famous_last_words }
  end
end
