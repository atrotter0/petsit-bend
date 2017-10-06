require 'will_paginate/array'

class ReservationsController < ApplicationController
  include FormHelper
  include ReservationHelper
  include PaginateHelper
  before_action :set_reservation, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user

  RESERVATIONS_PER_PAGE_USER = 8
  RESERVATIONS_PER_PAGE_ADMIN = 10

  def index
    if current_user.admin?
      @reservations = Reservation.all
      @reservations = setup_sort_paginate('admin', RESERVATIONS_PER_PAGE_ADMIN) if @reservations.present?
    else
      @reservations = Reservation.where(user_id: current_user.id)
      @reservations = setup_sort_paginate(current_user.id, RESERVATIONS_PER_PAGE_USER) if @reservations.present?
    end
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    create_pet_list if params[:pet_list].present?
    get_user_id
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
    get_user_id
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
    params.require(:reservation).permit(:pet_list, :start_date, :end_date, :medications, :special_instructions, :user_list)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def create_pet_list
    # we need to clean up pet_list if admin creates the reservation
    # admin pet_list comes across as: pet_list => ["Frankie, user id: 2", "Orange, user id: 2"]
    params[:pet_list] = remove_user_ids(params[:pet_list]) if params[:pet_list].first.include?(',')
    if params[:pet_list].count > 1
      list = params[:pet_list].map{ |pet| "#{pet}" }.join(", ")
    else
      list = params[:pet_list].first
    end
    @reservation.pet_list = list
  end

  def remove_user_ids(pet_list)
    pet_list.each do |item|
      pet_list[pet_list.index(item)] = item.split(',').first
    end
    pet_list
  end

  def get_user_id
    return current_user.id unless params[:user_list].present?

    @reservation.user_id = get_selected_user_id(params[:user_list])
  end

  def get_selected_user_id(user_list)
    # we need to get and set the user_id if admin creates the reservation
    # admin user_list comes across as: user_list = ["Abe Test, user id: 2"]
    user_list.first.split(':').last.strip!
  end

  def require_same_user
    return if @reservation.nil?
    if current_user != @reservation.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own reservations."
      redirect_to root_path
    end
  end
end
