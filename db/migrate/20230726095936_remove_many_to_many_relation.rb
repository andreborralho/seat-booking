class RemoveManyToManyRelation < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :reservation_id, :integer
    add_foreign_key :seats, :reservations
    drop_table :reservations_seats
    remove_column :reservations, :seat_id
  end
end
