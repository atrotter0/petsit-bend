class WalkingSchedule < ActiveRecord::Base
  include PetHelper

  belongs_to :user

  validates :user_id, presence: true
  validates :pet_list, presence: true, length: { maximum: 50 }
  validate :scheduled_times

  validate :time_format
  validate :check_pet_list

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
      self.errors.add(:time_selected, "is invalid")
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
    regex_test_one = /^([1-9]|1[012])\s[a-z][a-z]$/
    regex_test_two = /^([1-9]|1[012])\s[a-z][a-z].\s([1-9]|1[012])\s[a-z][a-z]$/
    regex_test_three = /^([1-9]|1[012])\s[a-z][a-z].\s([1-9]|1[012])\s[a-z][a-z].\s([1-9]|1[012])\s[a-z][a-z]$/

    list.each do |item|
      if regex_test_one === item || regex_test_two === item || regex_test_three === item || item == ""
        next
      else
        return false
      end
    end
  end

  def check_pet_list
    unless valid_pet_list?
      self.errors.add(:pet_list, "is invalid")
    end
  end

  def valid_pet_list?
    pet_list = pet_names_for_user(self.user)
    return false unless pet_list.include?(self.pet_list)
    return true
  end
end
