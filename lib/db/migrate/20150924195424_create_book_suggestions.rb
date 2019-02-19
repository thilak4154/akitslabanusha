class CreateBookSuggestions < ActiveRecord::Migration
  def change
    create_table :book_suggestions do |t|
        t.string :isbn
        t.string :name, :null => false
        t.string :authors, :null => false
        t.string :description
        t.timestamps null: false
    end
  end
end
