FactoryBot.define do
  factory :device do
    association :user
    platform { "ios" }
    token { "78c9741b1e88d38bc8151144da87b3a571920c1efe3f271191e5560762fbfdf8" }
  end

  factory :user do
    username { "michaeljordan" }
    password { "secret123" }
    password_confirmation { "secret123" }
    email { "michaeljordan@gmail.com" }
    firstname { "Michael" }
    lastname { "Jordan" }
    dob { 18.years.ago }
    phone { "1234567890" }
  end

  factory :game do
    name { "game1" }
    date { Date.current }
    time { Time.current }
    description { "a basketball game" }
    private { false }
    longitude { 0.0 }
    latitude { 0.0 }
    shortAddress { "5700 Wilkins Ave" }
    longAddress { "5700 Wilkins Avenue, Pittsburgh, PA" }
  end

  factory :player do
    status { "going" }
    association :user
    association :game
  end

  factory :favorite do
    association :favoriter
    association :favoritee
  end

  factory :contact do
    firstName { "Jeffrey" }
    lastName { "Igims" }
    phone { "4123549286" }
    association :user
  end

  factory :user_contact do
    association :user
    association :contact
  end
end