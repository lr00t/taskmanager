require 'faker'

namespace :db  do
  desc 'Create fake data'
  task fake_data: :environment do
    print 'Start'

    users_count = (1..5).to_a.sample
    tasks_range = (1..10)
    states = %w(new started finished).freeze

    users_count.times do
      print '.'

      u = User.create!(email: Faker::Internet.unique.email,
                       password: Faker::Internet.password)

      tasks_range.to_a.sample.times do
        u.tasks.create(name: Faker::Lorem.sentence,
                       description: Faker::Lorem.paragraph,
                       state: states.sample)
      end
    end
    print 'Done'
  end
end
