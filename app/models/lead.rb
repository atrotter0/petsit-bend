class Lead < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :email, presence: true, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :phone, presence: true, length: { minimum: 14, maximum: 14 }
  validates :message, presence: true, length: { maximum: 300 }
end
