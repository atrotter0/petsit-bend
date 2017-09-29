class Reservation < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :special_instructions, length: { maximum: 250 }
  validates :pet_list, presence: true
end