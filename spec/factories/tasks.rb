FactoryBot.define do
  factory :task do
    association :user

    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', 'apples.png')) }
    state { 'new' }
  end
end