class User < ActiveRecord::Base
  has_many :pets, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_one :testimonial, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :phone, presence: true, length: { minimum: 9, maximum: 14 }
  validates :address, presence: true, length: { minimum: 4, maximum: 100 }

  has_secure_password
end
