# Preview all emails at http://localhost:3000/rails/mailers/lead_mailer
class LeadMailerPreview < ActionMailer::Preview
  def new_lead_notifier
    lead = Lead.last
    LeadMailer.new_lead_notifier(lead)
  end
end