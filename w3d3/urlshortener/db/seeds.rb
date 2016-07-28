# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'sisi@email.com')
User.create!(email: 'linda@email.com')

ShortenedUrl.create_for_user_and_long_url!(User.find(1), 'http://apidock.com/jgkfurails/ActiveRnbdfbecord/ConnectionAdapters/SchemaStatements/add_index')
ShortenedUrl.create_for_user_and_long_url!(User.find(1), 'http://allrecipes.com/recipekjdfgrs/367/desserts/pies/kjfhjhwebf/mkfghklaeerg/0983757rjgkfj')


Visit.record_visit!(User.first, ShortenedUrl.first)
Visit.record_visit!(User.first, ShortenedUrl.first)
Visit.record_visit!(User.first, ShortenedUrl.first)
Visit.record_visit!(User.find(2), ShortenedUrl.first)
Visit.record_visit!(User.find(1), ShortenedUrl.find(2))
