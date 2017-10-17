class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token

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

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    return true if reset_sent_at.nil?

    reset_sent_at < 2.hours.ago
  end
end
