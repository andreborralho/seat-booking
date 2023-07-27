class LoadSeatsInteractor
  def initialize(session_id)
    @session_id = session_id
  end

  def call
    reservation = Reservation.find_or_create_by(session_id: @session_id)
    reservation.seats.update_all(status: Seat.statuses[:free])
    reservation.seats.delete_all
    seats = Seat.all.includes(:reservation)

    {
      all: seats,
      maxX: seats.maximum(:positionX) + 1,
      maxY: seats.maximum(:positionY) + 1,
      reservation: reservation
    }
  end
end
