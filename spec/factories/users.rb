FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 0 }
  end

  factory :invalid_user, class: 'User' do
    email { 'test' }
    password { 'pass' }
    password_confirmation { 'pass' }
  end
end