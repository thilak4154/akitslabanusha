class AlterColumnBooksStatus < ActiveRecord::Migration
  def change
    change_column :books, :status, :integer
  end
end
