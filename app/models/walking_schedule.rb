class WalkingSchedule < ActiveRecord::Base
  belongs_to :user

  # validates :user_id, presence: true
  # validates :pet_list, presence: true

  # validate days_and_times
end
