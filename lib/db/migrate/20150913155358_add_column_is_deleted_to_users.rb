class AddColumnIsDeletedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :isDeleted, :boolean
  end
end
