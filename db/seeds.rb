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
  date_of_birth: Date.new(1991, 7, 24), summary: "This is my summary")

user2 = User.create!(email: "joe2", password: "joejoe",
  fname: "John", lname: "Masters", tagline: "life ain't grand",
  location: "Cleveland, OH", industry: "Law",
  date_of_birth: Date.new(1950, 1, 23), summary: "Summary 2")

user3 = User.create!(email: "joe3", password: "joejoe")
user4 = User.create!(email: "joe4", password: "joejoe")
user5 = User.create!(email: "joe5", password: "joejoe")
user6 = User.create!(email: "joe6", password: "joejoe")


exp1 = user1.experiences.create!(experience_type: 0, role: "Consultant",
  institution: "Big Co.", location: "Greenwich, CT", description: "very important work",
  start_date: Date.new(2012,1,1), end_date: Date.new(2012,1,1), field: nil)

exp2 = user1.experiences.create!(experience_type: 1, role: "Bachelors Degree",
  institution: "University College", location: "Sarasota, FL", description: "studied hard",
  start_date: Date.new(2009,1,1), end_date: Date.new(2013,1,1), field: "Psychology")
