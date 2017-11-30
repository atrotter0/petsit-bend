class WalkingSchedule < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :pet_list, presence: true, length: { maximum: 50 }
  validate :scheduled_times
  validate :time_format

  def scheduled_times
    unless any_days_and_times?
      self.errors.add(:days_and_times, "can't be blank")
    end
  end

  def any_days_and_times?
    if self.sunday_times.blank? && self.monday_times.blank? && self.tuesday_times.blank? && self.wednesday_times.blank? &&
      self.thursday_times.blank? && self.friday_times.blank? && self.saturday_times.blank?
        return false
    else
      return true
    end
  end

  def time_format
    unless valid_time_values?
      self.errors.add(:time_selected, "does not have an acceptable format")
    end
  end

  def valid_time_values?
    list = []
    get_times_for_validation(list)
    boolean_check = check_time_values(list)
    return boolean_check
  end

  def get_days_and_times
    list = WalkingSchedule.where(user: self.user).pluck(:sunday_times, :monday_times, :tuesday_times, :wednesday_times,
      :thursday_times, :friday_times, :saturday_times)
    list.flatten!
  end

  private

  def get_times_for_validation(array)
    array.push(self.sunday_times, self.monday_times, self.tuesday_times, self.wednesday_times, self.thursday_times, self.friday_times,
      self.saturday_times)
  end

  def check_time_values(list)
    list.each do |item|
      if (/^([1-9]|1[012])\s[A-Z][A-Z]$/ === item) || item == "" ? true : false
        return true
      else
        return false
      end
    end
  end
end
