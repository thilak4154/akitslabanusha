class AddForignKeyToReservations < ActiveRecord::Migration
  def change
    add_foreign_key :reservations, :users
    add_foreign_key :reservations, :books
  end
end
