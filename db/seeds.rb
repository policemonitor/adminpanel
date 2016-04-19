# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
first_hr = Administrator.create(lastname: 'Адміністратор', login: 'first.administrator', password_digest: '10qoakzm', personal_number: '9999999', rank: 2)
