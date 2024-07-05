# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.find_by(email: 'admin@example.com')
if Admin.find_by(email: 'admin@example.com')
    admin.update(password: "adminpassword") 
else
    Admin.create!(
      email: 'admin@example.com',
      password: 'adminpassword',
      password_confirmation: 'adminpassword'
    )
end
unless Admin.find_by(email: 'ilead@thecricauction.com')
  Admin.create!(
    email: 'ilead@thecricauction.com',
    password: 'tcailead',
    password_confirmation: 'tcailead'
  )
end
User.where(price: nil).update_all(price: 0)
Admin.find_each do |admin|
  admin.update(last_seen: Time.current)
end
AccessForm.where.not(contact_number: nil).delete_all