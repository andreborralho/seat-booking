module SeatsHelper
  def seat_css_class(seat, reservation)
    return 'own-selected selected' if seat.selected? && seat.reservation&.session_id == reservation.session_id

    seat.status
  end
end
