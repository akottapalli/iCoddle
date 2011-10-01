class Mailer < ActionMailer::Base
  default :from => "abc@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation(invitation, signup_url)
    puts "signup_url"
    puts signup_url
    puts "invitation"
    puts invitation.to_s
    @signup_url = signup_url
    subject    'Invitation to www.iCoddle.com'
    recipients invitation.recipient_email
    from       'CEO@iCoddle.com'
    body       :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute(:sent_at, Time.now)
  end
end
