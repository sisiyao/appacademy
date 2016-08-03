# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create([
  { birth_date: "2016/01/01", color: "brown", name: "Smelly", sex: "m",
    description: "Smells real bad." },
  { birth_date: "2016/02/01", color: "black", name: "Fluffy", sex: "f",
    description: "Very fluffy." },
  { birth_date: "2016/03/01", color: "white", name: "Roscoe", sex: "m",
    description: "Loves treats." },
  { birth_date: "2016/04/01", color: "orange", name: "Jigglypuff", sex: "f",
    description: "What a charmer." },
  { birth_date: "2016/05/01", color: "brown", name: "Sam", sex: "m",
    description: "The runt." }
  ])
