FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Abc123!!defghaijklmnop%' }

    trait :invalid_email do
      email { 'false email here' }
    end

    trait :password_missing_uppercase do
      password { 'abc123!!defghaijklmnop%' }
    end

    trait :password_missing_lowercase do
      password { 'ABC123!!DEFGHAIJKLMNOP%' }
    end

    trait :with_otp do
      otp_required_for_login { true }
      email { Faker::Internet.email }
      password { 'Abc123!!defghaijklmnop%' }

      after(:build) do |user, _evaluator|
        user.otp_secret = User.generate_otp_secret
        user.otp_plain_backup_codes = user.generate_otp_backup_codes!
      end
    end
  end
end
