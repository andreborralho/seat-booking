class CreateReservationSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :session_id, :integer

    create_table :reservations_seats, id: false do |t|
      t.integer :reservation_id
      t.integer :seat_id

      t.index [:reservation_id, :seat_id], unique: true
      t.index :seat_id
      t.timestamps
    end

    add_foreign_key :reservations_seats, :reservations
    add_foreign_key :reservations_seats, :seats
  end
end