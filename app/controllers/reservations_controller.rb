class ReservationsController < ApplicationController
  include FormHelper
  include ReservationHelper
  before_action :set_reservation, only: [:edit, :update, :show, :destroy]

  def index
    @reservations = Reservation.all
    @sorted_reservations = sort_by_date(@reservations, User.first.id).flatten!
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    create_pet_list if params[:pet_list].present?
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
    create_pet_list if params[:pet_list].present?
    if @reservation.update(reservation_params)
      flash[:success] = "Reservation was successfully updated!"
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
    params.require(:reservation).permit(:pet_list, :start_date, :end_date, :medications, :special_instructions)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def create_pet_list
    if params[:pet_list].count > 1
      list = params[:pet_list].map{ |pet| "#{pet}" }.join(", ")
    else
      list = params[:pet_list].first
    end

    @reservation.pet_list = list
  end
end