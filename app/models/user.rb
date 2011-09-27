class User < ActiveRecord::Base
  acts_as_authentic 
  #do |c|
  #  c.validate_login_field = false
  #end
  has_many :pets, :dependent => :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  #validates_presence_of :username, :message => 'cannot be empty'
  #validates_presence_of :invitation_id, :message => 'is required'
  #validates_uniqueness_of :invitation_id

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  before_create :set_invitation_limit
  after_create :set_invitation_status

  attr_accessible :username, :login, :email, :name, :password, :password_confirmation, :invitation_token

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  private

  def set_invitation_limit
    self.invitation_limit = 25
  end

  def set_invitation_status
    invites = Invitation.where(:recipient_email => self.email)
    invites.each do |invite|
      invite.status = 1
      invite.save
    end
  end

end
