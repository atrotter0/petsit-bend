class UserMailer < ApplicationMailer
  ADMIN_EMAIL = 'petsitbend@gmail.com'
  DO_NOT_REPLY_EMAIL = 'Petsit Bend <donotreply@petsitbend.com>'

  def sign_up(user)
    @user = user
    mail from: DO_NOT_REPLY_EMAIL, to: @user.email, bcc: ADMIN_EMAIL, subject: "Account Created"
  end

  def account_activation(user)
    @user = user
    mail from: DO_NOT_REPLY_EMAIL, to: @user.email, subject: "Account Activation Required"
  end

  def reservation(reservation)
    @reservation = reservation
    @user = @reservation.user
    mail from: DO_NOT_REPLY_EMAIL, to: @user.email, bcc: ADMIN_EMAIL, subject: "Reservation Confirmation"
  end

  def reservation_update(reservation)
    @reservation = reservation
    @user = @reservation.user
    mail from: DO_NOT_REPLY_EMAIL, to: @user.email, bcc: ADMIN_EMAIL, subject: "Reservation Updated"
  end

  def reservation_cancel(reservation)
    @reservation = reservation
    @user = @reservation.user
    mail from: DO_NOT_REPLY_EMAIL, to: @user.email, bcc: ADMIN_EMAIL, subject: "Reservation Cancelled"
  end

  def password_reset(user)
    @user = user
    mail from: DO_NOT_REPLY_EMAIL, to: user.email, subject: "Password Reset"
  end

  def dog_walking(schedule)
    @schedule = schedule
    mail from: DO_NOT_REPLY_EMAIL, to: ADMIN_EMAIL, subject: "New Dog Walking Schedule"
  end

  def dog_walking_update(schedule)
    @schedule = schedule
    mail from: DO_NOT_REPLY_EMAIL, to: ADMIN_EMAIL, subject: "Dog Walking Schedule Updated"
  end

  def dog_walking_cancel(schedule)
    @schedule = schedule
    mail from: DO_NOT_REPLY_EMAIL, to: ADMIN_EMAIL, subject: "Dog Walking Schedule Cancelled"
  end
end
