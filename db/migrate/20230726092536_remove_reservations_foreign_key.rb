class RemoveReservationsForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reservations, :seats
  end
end
