# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.find_or_create_by(email: 'txie145@gmail.com') do |user|
  user.name = 'Tony Xie'
  user.password = 'testtest'
  user.password_confirmation = 'testtest'
end
u.create_sms_response response: "Show this for 5% off your meal today!"
for x in 1..20
  s = u.sms_contacts.create number: "1604910#{x}"
  s.update_attribute :last_check_in, Date.today - 1.day - 1.week
end
for x in 1..20
  s = u.sms_contacts.create number: "1604910#{x}"
  s.update_attribute :last_check_in, Date.today - 1.day - 2.weeks
end
for x in 1..20
  s = u.sms_contacts.create number: "1604910#{x}"
  s.update_attribute :last_check_in, Date.today - 1.day - 1.month
end