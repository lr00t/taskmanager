FactoryBot.define do
  factory :task do
    association :user

    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    file { Rack::Test::UploadedFile.new(attachment_path) }
    state { 'new' }
  end
end