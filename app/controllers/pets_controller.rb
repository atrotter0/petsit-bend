class PetsController < ApplicationController
  include PetsHelper
  before_action :set_pet, only: [:edit, :update, :show, :destroy]

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = 1 #remove me later
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
end
