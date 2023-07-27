class ReserveSeatsInteractor
  def initialize(session_id)
    @session_id = session_id
  end

  def call
    reservation = Reservation.find_or_create_by(session_id: @session_id.to_s)
    seats = reservation.seats.where(status: Seat.statuses[:selected])
    seats.update(status: Seat.statuses[:reserved])
  end
end
