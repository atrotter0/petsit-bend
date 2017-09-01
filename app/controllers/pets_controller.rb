class PetsController < ApplicationController
  before_action :set_pet, only: [:edit, :update, :show, :destroy]

  def index
    @pets = Pet.all
  end

  def create
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :type, :age, :color)
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end
end
