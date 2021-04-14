FactoryBot.define do
  factory :conversation do
    user_one { association :user }
    user_two { association :user }
  end
end
