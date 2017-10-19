# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def sign_up
    user = User.last
    UserMailer.sign_up(user)
  end

  def account_activation
    user = User.last
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def reservation
    reservation = Reservation.last
    UserMailer.reservation(reservation)
  end

  def reservation_update
    reservation = Reservation.last
    UserMailer.reservation_update(reservation)
  end

  def reservation_cancel
    reservation = Reservation.last
    UserMailer.reservation_cancel(reservation)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end
end
