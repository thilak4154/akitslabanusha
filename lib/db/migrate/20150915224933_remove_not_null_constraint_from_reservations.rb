class RemoveNotNullConstraintFromReservations < ActiveRecord::Migration
  def change
    change_column :reservations, :dateReturned, :datetime, :null => true
  end
end

