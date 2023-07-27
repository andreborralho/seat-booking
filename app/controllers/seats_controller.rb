# app/controllers/seats_controller.rb
class SeatsController < ApplicationController

  def index
    interactor = LoadSeatsInteractor.new(session.id.to_s)
    @seats = interactor.call
  end

  def update
    interactor = UpdateSeatInteractor.new(session.id, params[:id])
    result = interactor.call

    render json: result
  end

  def update_multiple
    seat_ids = params[:seat_ids]
    interactor = ReserveSeatsInteractor.new(seat_ids, session.id)
    result = interactor.call

    render json: result
  end
end
