# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
TaskStatus.delete_all
User.delete_all
TaskStatus.create(status: 'New')
TaskStatus.create(status: 'AnswerGiven')
TaskStatus.create(status: 'QuestionAsked')
TaskStatus.create(status: 'Closed')
User.create(username: 'Admin', email: 'admin@example.com', password: 'password', admin: true, confirmation_token: nil, confirmed_at: '2015-06-25 14:34:42.025673' )