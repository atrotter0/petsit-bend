class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(leads_params)
    if @lead.save
      @lead.send_new_lead_notifier
      redirect_to thank_you_path
    else
      render 'new'
    end
  end

  private

  def leads_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone, :reason, :message)
  end
end
