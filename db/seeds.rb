# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
p "Creating admin user"

user = User.new(
    email: "jean@bon.fr",
    password: "qwerty",
    password_confirmation: "qwerty",
    role: "admin"
)
user.save

unless Rails.env.test?
  user.avatar.attach(
    io: File.open(Rails.root.join("app/assets/images/jean.avif")),
    filename: "jean.avif"
  )
end

p "User jean@bon.fr with password qwerty created 🚀"
