class WalkingSchedule < ActiveRecord::Base
  belongs_to :user

  # validates :user_id, presence: true
  # validates :pet_list, presence: true

  # validate days_and_times

  def get_days_and_times
    list = WalkingSchedule.where(user: self.user).pluck(:sunday_times, :monday_times, :tuesday_times, :wednesday_times,
      :thursday_times, :friday_times, :saturday_times)
    list.flatten!
  end
end
