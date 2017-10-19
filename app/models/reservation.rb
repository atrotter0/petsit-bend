class Reservation < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :special_instructions, length: { maximum: 250 }
  validates :pet_list, presence: true

  validate :check_end_date

  def check_end_date
    unless valid_end_date?
      self.errors.add(:reservation_end_date, "can't be before start date")
    end
  end

  def valid_end_date?
    end_date = Date.strptime(self.end_date, '%m/%d/%Y').to_date
    start_date = Date.strptime(self.start_date, '%m/%d/%Y').to_date
    end_date >= start_date
  end
end
