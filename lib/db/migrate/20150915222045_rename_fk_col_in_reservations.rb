class RenameFkColInReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :users_id, :user_id
    rename_column :reservations, :books_id, :book_id
  end
end
