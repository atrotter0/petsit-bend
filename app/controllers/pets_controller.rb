require 'will_paginate/array'

class PetsController < ApplicationController
  include FormHelper
  include PetHelper
  include PaginateHelper
  include UserHelper
  before_action :set_pet, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user

  PETS_PAGINATE_LIMIT = 6

  def index
    if current_user.admin?
      @pets = Pet.all
      @pets = sort_pets_by_user.paginate(paginate_settings(PETS_PAGINATE_LIMIT))
    else
      @pets = Pet.where(user_id: current_user.id).order("name ASC").paginate(paginate_settings(PETS_PAGINATE_LIMIT))
    end
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = get_user_id
    if @pet.save
      flash[:success] = "Pet successfully created!"
      redirect_to pet_path(@pet)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @pet.user_id = get_user_id
    if @pet.update(pet_params)
      flash[:success] = "#{@pet.name} was successfully updated!"
      redirect_to pet_path(@pet)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @pet.destroy
    flash[:danger] = "Pet was successfully deleted!"
    redirect_to pets_path
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :age, :color, :user_list)
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def require_same_user
    return if @pet.nil?
    if current_user != @pet.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own reservations."
      redirect_to root_path
    end
  end
end
