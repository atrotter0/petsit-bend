class User < ActiveRecord::Base
  attr_accessor :reset_token, :activation_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :pets, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_one :testimonial, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_activation_digest

  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :phone, presence: true, length: { minimum: 14, maximum: 14 }
  validates :address, presence: true, length: { minimum: 4, maximum: 100 }

  has_secure_password

  def set_last_login
    update_attribute(:last_login, Time.now)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def send_account_activation
    UserMailer.account_activation(self).deliver_now
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def create_activation_reset_digest
    self.activation_token = User.new_token
    update_attribute(:activation_digest, User.digest(activation_token))
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

  def send_sign_up_email
    UserMailer.sign_up(self).deliver_now
  end

  def send_reservation_email(reservation)
    UserMailer.reservation(reservation).deliver_now
  end

  def send_reservation_update_email(reservation)
    UserMailer.reservation_update(reservation).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
