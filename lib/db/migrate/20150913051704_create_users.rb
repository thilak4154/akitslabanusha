class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

    	t.string :name, :limit => 100, :null => false
    	t.string :email, :limit => 50, :null => false
    	t.string :password, :null => false
    	t.string :type, :null => false

      t.timestamps null: false
    end

    add_index :users, :email, :unique => true
  end
end
