require 'will_paginate/array'

class PetsController < ApplicationController
  include FormHelper
  include PetHelper
  include PaginateHelper
  before_action :set_pet, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user

  def index
    if current_user.admin?
      @pets = Pet.all
      @pets = sort_pets_by_user
    else
      @pets = Pet.where(user_id: current_user.id).order("name ASC")
    end
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = set_pet_user_id
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
    params.require(:pet).permit(:name, :pet_type, :age, :color)
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

  def set_pet_user_id
    #return params[:user_id] if current_user.admin?
    current_user.id
  end
end
