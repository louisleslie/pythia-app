# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clean out existing properties and user accounts. 


users = ['alex.terenda@gmail.com', 'jake.howlett@gmail.com', 'louis.leslie@gmail.com', 'yunus.firat@gmail.com']

users.each do |user|
   User.create(email: user, password: "password", password_confirmation: "password")
end
