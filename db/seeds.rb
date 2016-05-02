# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Administrator.create(lastname: 'Адміністратор', login: 'administrator', password: '1q1q1q', personal_number: '9999999', rank: 2)
Administrator.create(lastname: 'Капорін Роман Михайлович', login: 'roman.kaporin', password: '1q1q1q', personal_number: '0000001', rank: 1)
Administrator.create(lastname: 'Когулько Олександр Сергійович', login: 'alexandr.kogulko', password: '1q1q1q', personal_number: '0000002', rank: 2)
