class FixColAuthorToAuthorsInBooks < ActiveRecord::Migration
  def change
    rename_column :books, :author, :authors
  end
end
