class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update, :show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def create
    @reservation = Reservation.new
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def reservation_params
    params.require(:reservation).permit(:number_of_pets, :start_date, :end_date)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end