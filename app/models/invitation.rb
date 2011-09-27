class Invitation < ActiveRecord::Base
  attr_accessible :sender_id, :recipient_email, :token, :sent_at, :status
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  validates_presence_of :recipient_email
  validate :recipient_is_not_registered
  validate :sender_has_invitations, :if => :sender
  #validate :invitation_is_not_to_self

  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender

  private

  def invitation_is_not_to_self
    return true
    #errors.add 'Inviting yourself' if :recipient_email == current_user.email
  end

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end

  def sender_has_invitations
    return true
    unless sender.invitation_limit > 0
      errors.add_to_base 'You have reached your limit of invitations to send.'
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def decrement_sender_count
    sender.decrement! :invitation_limit
  end

  public

  def set_status(status)
    self.status = status
  end

end
