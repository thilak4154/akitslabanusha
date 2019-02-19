class AddDefaultValueForIsDeletedInBooks < ActiveRecord::Migration
  def change
    change_column :books, :isDeleted, :boolean, :default => false
  end
end
