class UserMailer < ApplicationMailer
  def sign_up(user)
    @user = user
    mail from: "Petsit Bend <donotreply@petsitbend.com>", to: @user.email, bcc: "petsitbend@gmail.com", subject: "Account Created"
  end

  def reservation(reservation)
    @reservation = reservation
    @user = @reservation.user
    mail from: "Petsit Bend <donotreply@petsitbend.com>", to: @user.email, bcc: "petsitbend@gmail.com", subject: "Reservation Confirmation"
  end

  def reservation_update(reservation)
    @reservation = reservation
    @user = @reservation.user
    mail from: "Petsit Bend <donotreply@petsitbend.com>", to: @user.email, bcc: "petsitbend@gmail.com", subject: "Reservation Updated"
  end

  def password_reset(user)
    @user = user
    mail from: "Petsit Bend <donotreply@petsitbend.com>", to: user.email, subject: "Password Reset"
  end
end
