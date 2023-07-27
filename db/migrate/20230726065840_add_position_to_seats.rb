class AddPositionToSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :positionX, :integer
    add_column :seats, :positionY, :integer
  end
end
