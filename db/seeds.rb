# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.where('email = ?', 'txie145@gmail.com')[0]
for x in 1...10 
  u.sms_contacts.create number: "1604910886#{x}"
end
for x in 1..100
  u.reviews.create body: "Pilsner is the best!", from_number: "1604910886#{x}"
end
for x in 1..150
  u.sms_contacts.create number: "1604910886#{x}"
end