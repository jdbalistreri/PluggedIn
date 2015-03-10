# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create!(email: "joe", password: "joejoe",
  fname: "Joe", lname: "Bali", tagline: "ain't life grand?",
  location: "Milwaukee, WI", industry: "Computer Software",
  date_of_birth: "07/24/1991", summary: "This is my summary")

user2 = User.create!(email: "joe2", password: "joejoe",
  fname: "John", lname: "Masters", tagline: "life ain't grand",
  location: "Cleveland, OH", industry: "Law",
  date_of_birth: "01/21/1950", summary: "Summary 2")

user3 = User.create!(email: "joe3", password: "joejoe")
user4 = User.create!(email: "joe4", password: "joejoe")
user5 = User.create!(email: "joe5", password: "joejoe")
user6 = User.create!(email: "joe6", password: "joejoe")
