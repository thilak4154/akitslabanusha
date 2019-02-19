# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#The preconfigured admin


 User.create(name: 'superUser', email: 'superUser@libsys.com', password: 'Password12', isDeleted: FALSE,
              role: User::IS_ADMIN)

#Default members
(1...6).each do |i|
name = 'member'+i.to_s
email = 'member'+i.to_s+'@gmail.com'
password = 'member'+i.to_s+'pwd'
User.create(name: name, email: email, password: password, isDeleted: FALSE,
            role: User::IS_MEMBER)
end



#Default books
 (1...6).each do |i|
   isbn = '978-3-16-148410-0-'+(i*20).to_s
   name = 'Book00'+i.to_s
   authors= 'Author'+i.to_s+', Author'+(i+1).to_s
   description = 'description string for book'+i.to_s
   Book.create(isbn:isbn, name: name, authors:authors,  description: description, isDeleted: FALSE,
               status: 0)
 end


Reservation.create(user_id: 4, book_id: 1, dateIssued: Time.now.getutc)
 Reservation.create(user_id: 2, book_id: 2, dateIssued: Time.now.getutc)
 Reservation.create(user_id: 3, book_id: 3, dateIssued: Time.now.getutc)
 Reservation.create(user_id: 4, book_id: 4, dateIssued: Time.now.getutc)

books_status_update = Book.where(id: [1,2,3,4])
books_status_update.update_all(status: 1)
