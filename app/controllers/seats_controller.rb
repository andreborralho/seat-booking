# app/controllers/seats_controller.rb
class SeatsController < ApplicationController

  def index
    interactor = LoadSeatsInteractor.new(session.id.to_s)
    @seats = interactor.call
  end

  def update
    interactor = UpdateSeatInteractor.new(session.id, params[:id])
    interactor.call
  end

  def update_multiple
    interactor = ReserveSeatsInteractor.new(session.id)
    interactor.call
  end
end
