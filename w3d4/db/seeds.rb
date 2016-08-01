# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users for our Poll App
User.create!(user_name: "axel")
User.create!(user_name: "claire")
User.create!(user_name: "sisi")
User.create!(user_name: "gage")

# Two total polls, from Axel and Sisi
Poll.create!(title: "Poll number 1", author_id: 1)
Poll.create!(title: "Poll number 2", author_id: 3)

# Axel's Poll's Questions
Question.create!(poll_id: 1, text: "Question 1 for Poll 1")
Question.create!(poll_id: 1, text: "Question 2 for Poll 1")
Question.create!(poll_id: 1, text: "Question 3 for Poll 1")

# Sisi's Poll's Questions
Question.create!(poll_id: 2, text: "Question 1 for Poll 2")
Question.create!(poll_id: 2, text: "Question 2 for Poll 2")

# Axel's Poll's Question's Answers
AnswerChoice.create!(question_id: 1, text: "Choice 1 for Question 1")
AnswerChoice.create!(question_id: 1, text: "Choice 2 for Question 1")
AnswerChoice.create!(question_id: 1, text: "Choice 3 for Question 1")
AnswerChoice.create!(question_id: 1, text: "Choice 4 for Question 1")
AnswerChoice.create!(question_id: 2, text: "Choice 1 for Question 2")
AnswerChoice.create!(question_id: 2, text: "Choice 2 for Question 2")
AnswerChoice.create!(question_id: 3, text: "Choice 1 for Question 3")
AnswerChoice.create!(question_id: 3, text: "Choice 2 for Question 3")

# Sisi's Poll's Question's Answers
AnswerChoice.create!(question_id: 4, text: "Choice 1 for Question 4")
AnswerChoice.create!(question_id: 4, text: "Choice 2 for Question 4")
AnswerChoice.create!(question_id: 5, text: "Choice 1 for Question 5")

# Axel's Poll's responses
# Question 1 Claire
Response.create!(user_id: 2, answer_choice_id: 1)
# Question 2 Claire
Response.create!(user_id: 2, answer_choice_id: 6)
# Question 3 Claire
Response.create!(user_id: 2, answer_choice_id: 8)

# Question 3 Sisi
Response.create!(user_id: 3, answer_choice_id: 7)
Response.create!(user_id: 4, answer_choice_id: 8)
