class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    	t.string :isbn, :null => false
    	t.string :name, :null => false
    	t.string :author, :null => false
    	t.string :description
    	t.string :status, :null => false

      t.timestamps null: false
    end
    add_index :books, :isbn, :unique => true
  end
end
