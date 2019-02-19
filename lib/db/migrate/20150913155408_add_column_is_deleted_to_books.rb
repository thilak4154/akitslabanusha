class AddColumnIsDeletedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :isDeleted, :boolean
  end
end
