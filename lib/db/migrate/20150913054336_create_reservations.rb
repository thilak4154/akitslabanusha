class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
    	t.references :users, :null => false
    	t.references :books, :null => false
    	t.timestamp :dateIssued, :null => false
    	t.timestamp :dateReturned, :null => false

      t.timestamps null: false
    end
  end
end
