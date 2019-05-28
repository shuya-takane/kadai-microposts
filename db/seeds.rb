# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |num|
  user = User.create(name: "test#{num}", email: "test#{num}@example.com", password: "test")
  100.times do
    user.microposts.create(content: "aaa")
  end
end