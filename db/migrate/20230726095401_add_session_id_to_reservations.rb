class AddSessionIdToReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :user_id
  end
end
