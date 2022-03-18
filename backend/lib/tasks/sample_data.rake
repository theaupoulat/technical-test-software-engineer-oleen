namespace :db do
  namespace :sample do
    desc 'Drop, create, migrate, seed and populate sample data'
    task prepare: [:drop, :create, "schema:load", :seed, :populate] do
      puts 'Ready to go!'
    end

    desc 'Populates the database with sample data'
    task populate: :environment do
      10.times {
        username = Faker::Name.name
        email = Faker::Internet.email(name: username)
        User.create!(username:, email:)
      }
    end
  end
end
