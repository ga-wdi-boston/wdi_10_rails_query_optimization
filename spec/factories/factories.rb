FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
