# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!( name:   "admin" ,
                email: "admin@gmail.com" ,
                password:   "12345677" ,
                password_confirmation: "12345677" ,
                admin: true )
20.times do |t|
   User.create! :email => "itsme#{t}@gmail.com", :password => "mysecret#{t}", :password_confirmation =>
   "mysecret#{t}", :admin => true
end
