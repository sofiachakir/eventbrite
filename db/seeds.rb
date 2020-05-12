# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Sets the locale to "France":
Faker::Config.locale = 'fr'

# Détruire la base actuelle
Event.destroy_all
User.destroy_all

# Remettre les compteurs à 0
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

10.times do |i|
	User.create(password: "motdepasse", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "crazyeventbritemail0#{i}@yopmail.com", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: true))
end

10.times do |i|
	added_days = rand(1..7)
	start_date = Time.now + added_days.days
	Event.create(start_date: start_date, duration: 30, title: Faker::Space.star, description: Faker::ChuckNorris.fact , location: Faker::Restaurant.name, price: rand(1..1000), admin: User.all.sample)
end