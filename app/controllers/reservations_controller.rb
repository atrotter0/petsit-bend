class ReservationsController < ApplicationController
  include FormHelper
  before_action :set_reservation, only: [:edit, :update, :show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = 1 #remove me later
    if @reservation.save
      flash[:success] = "Reservation successfully created!"
      redirect_to reservation_path(@reservation)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @reservation.update(reservation_params)
      flash[:success] = "Reservation #{@reservation.id} was successfully updated!"
      redirect_to reservation_path(@reservation)
    else
      render 'edit'
    end
  end

  def destroy
    @reservation.destroy
    flash[:danger] = "Reservation was successfully cancelled!"
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:number_of_pets, :start_date, :end_date)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end