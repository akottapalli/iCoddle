class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    puts params["invitation"]
    puts params[:invitation]
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      if logged_in?
        Mailer.invitation(@invitation, signup_url("#{@invitation.token}")).deliver
        #Mailer.invitation(@invitation, signup_url+"/#{@invitation.token}").deliver
        redirect_to users_url, :notice => "Thank you, invitation sent."
      else
        redirect_to users_path, :notice => "Thank you, we will notify when we are ready."
      end
    else
      render :action => 'new'
    end
  end
end
