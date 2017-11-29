class WalkingSchedulesController < ApplicationController
  include UserHelper
  include FormHelper

  before_action :set_schedule, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user

  def index
    if current_user.admin?
      @schedule = WalkingSchedule.all
    else
      @schedule = WalkingSchedule.where(user_id: current_user.id)
    end
  end

  def new
    @schedule = WalkingSchedule.new
  end

  def create
    @schedule = WalkingSchedule.new(schedule_params)
    @schedule.user_id = get_user_id
    if @schedule.save
      flash[:success] = "Dog walking schedule successfully created!"
      redirect_to walking_schedules_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @schedule.user_id = get_user_id
    if @schedule.update(schedule_params)
      flash[:success] = "Your dog walking schedule was successfully updated!"
      redirect_to walking_schedules_path
    else
      render 'edit'
    end
  end

  def destroy
    @schedule.destroy
    flash[:danger] = "Dog walking schedule was successfully deleted!"
    redirect_to walking_schedules_path
  end

  private

  def schedule_params
    params.require(:walking_schedule).permit(:pet_list, :sunday_times, :monday_times, :tuesday_times, :wednesday_times, :thursday_times,
      :friday_times, :saturday_times)
  end

  def set_schedule
    @schedule = WalkingSchedule.find(params[:id])
  end

  def require_same_user
    return if @schedule.nil?
    if current_user != @schedule.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own dog walking schedules."
      redirect_to root_path
    end
  end
end
