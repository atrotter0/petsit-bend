class Reservation < ActiveRecord::Base
  include PetHelper

  belongs_to :user

  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :special_instructions, length: { maximum: 250 }
  validates :pet_list, presence: true, length: { maximum: 100 }

  validate :check_end_date
  validate :check_pet_list

  def check_end_date
    unless valid_end_date?
      self.errors.add(:reservation_end_date, "can't be before start date")
    end
  end

  def valid_end_date?
    return unless self.start_date.present? && self.end_date.present?
    end_date = Date.strptime(self.end_date, '%m/%d/%Y').to_date
    start_date = Date.strptime(self.start_date, '%m/%d/%Y').to_date
    end_date >= start_date
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
