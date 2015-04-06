FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    encrypted_password { Faker::Internet.password }
    reset_password_token
    reset_password_sent_at
    remember_created_at
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
  end

end