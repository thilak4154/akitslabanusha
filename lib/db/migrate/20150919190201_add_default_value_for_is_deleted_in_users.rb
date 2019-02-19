class AddDefaultValueForIsDeletedInUsers < ActiveRecord::Migration
  def change
    change_column :users, :isDeleted, :boolean, :default => false
  end
end
