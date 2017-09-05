class User < ActiveRecord::Base
  has_many :pets
  has_many :reservations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false}
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :phone, presence: true, length: { maximum: 14 }
  validates :address, presence: true, length: { maximum: 50 }
end
