class Pet < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :pet_type, presence: true
  validates :age, presence: true
  validates :color, presence: true, length: { maximum: 50 }
end
