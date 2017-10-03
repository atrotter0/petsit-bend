class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:edit, :update, :show, :destroy]
  #before_action :require_user
  #before_action :require_same_user

  def index
    @testimonials = Testimonial.all
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user_id = current_user.id
    if @testimonial.save
      flash[:success] = "Testimonial successfully submitted! You testimonial will be reviewed shortly."
      redirect_to testimonials_path
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @testimonial.update(testimonial_params)
      flash[:success] = "Testimonial was successfully updated!"
      redirect_to testimonial_path(@testimonial)
    else
      render 'edit'
    end
  end

  def destroy
    @testimonial.destroy
    flash[:danger] = "Testimonial was successfully destroyed!"
    redirect_to testimonials_path
  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:body, :approved)
  end

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end
end