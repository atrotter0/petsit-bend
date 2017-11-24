class LeadMailer < ApplicationMailer
  ADMIN_EMAIL = 'petsitbend@gmail.com'
  DO_NOT_REPLY_EMAIL = 'Petsit Bend <donotreply@petsitbend.com>'

  def new_lead_notifier(lead)
    @lead = lead
    mail from: DO_NOT_REPLY_EMAIL, to: ADMIN_EMAIL, subject: "New Lead Submitted"
  end
end
