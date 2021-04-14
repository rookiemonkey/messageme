FactoryBot.define do
  factory :message do
    association :user
    body { Faker::Quote.famous_last_words }
  end
end
