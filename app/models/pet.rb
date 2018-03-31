class Pet < ActiveRecord::Base
  MAX_BREED_LENGTH = 35

  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :pet_type, presence: true
  validates :age, presence: true
  validates :color, presence: true, length: { maximum: 50 }

  validate :check_breed
  validate :breed_length

  def check_breed
    if self.pet_type == "Dog" && self.breed.empty?
      self.errors.add(:breed, "can't be blank")
    end
  end

  def breed_length
    if self.pet_type == "Dog" && self.breed.length > MAX_BREED_LENGTH
      self.errors.add(:breed, "is too long")
    end
  end
end
