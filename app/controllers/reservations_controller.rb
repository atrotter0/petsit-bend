require 'will_paginate/array'

class ReservationsController < ApplicationController
  include FormHelper
  include ReservationHelper
  include PaginateHelper
  include UserHelper
  before_action :set_reservation, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user

  RESERVATIONS_PAGINATE_LIMIT = 20

  def index
    if current_user.admin?
      @reservations = Reservation.all
      @reservations = setup_sort_paginate('admin', RESERVATIONS_PAGINATE_LIMIT) if @reservations.present?
    else
      @reservations = Reservation.where(user_id: current_user.id)
      @reservations = setup_sort_paginate(current_user.id, RESERVATIONS_PAGINATE_LIMIT_USER) if @reservations.present?
    end
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    create_pet_list if params[:pet_list].present?
    @reservation.user_id = get_user_id
    if @reservation.save
      @reservation.user.send_reservation_email(@reservation)
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
    @reservation.user_id = get_user_id
    if @reservation.update(reservation_params)
      @reservation.user.send_reservation_update_email(@reservation)
      flash[:success] = "Reservation was successfully updated!"
      redirect_to reservation_path(@reservation)
    else
      render 'edit'
    end
  end

  def destroy
    @reservation.user.send_reservation_cancel_email(@reservation)
    @reservation.destroy
    flash[:danger] = "Reservation was successfully cancelled!"
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:pet_list, :start_date, :end_date, :medications, :special_instructions, :user_list)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def require_same_user
    return if @reservation.nil?
    if current_user != @reservation.user && !current_user.admin?
      flash[:danger] = "You can only update or cancel your own reservations."
      redirect_to root_path
    end
  end
end
