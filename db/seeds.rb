# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
def price_per_column(column_number)
  case column_number
  when 0..1
    return 150
  when 2..10
    return 100
  else
    return 50
  end
end

Seat.transaction do
  rows = 25
  columns = 20

  rows.times do |row|
    columns.times do |column|
      Seat.create!(
        positionX: column,
        positionY: row,
        status: 'free',
        price: price_per_column(row)
      )
    end
  end
end
