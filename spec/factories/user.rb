FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    password { '987654321' }
  end
end
