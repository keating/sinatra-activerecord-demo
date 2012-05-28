require "active_record"
require "active_support/core_ext"
require_relative "models/user"
require "faker"

namespace :db do

  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Migration.verbose = true

  task :environment do
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))["development"])
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Migrator.migrate("db/migrate")
  end

  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  20.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end