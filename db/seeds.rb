# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

users = 10.times.map do
  User.create!(name: Faker::Name.name,
               email: Faker::Internet.unique.email,
               password_digest: "password")
end

shops = 10.times.map do
  Shop.create!(name: Faker::Commerce.department,
               address: Faker::Address.street_address,
               phone_number: Faker::Number.number(digits: 9),
               opening_hours: "9:00 - 18:00",
               place_id: SecureRandom.uuid)
end

10.times do |index|
  Post.create!(user: users[index],
               shop: shops[index],
               title: "タイトル#{index}",
               body: "本文#{index}",
               quietness_level: rand(1..5),
               seat_comfort_level: rand(1..5),
               wifi_comfort_level: rand(1..5),
               power_availability: rand(1..5))
end
