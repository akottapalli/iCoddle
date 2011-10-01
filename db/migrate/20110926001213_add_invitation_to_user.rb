class AddInvitationToUser < ActiveRecord::Migration
  def change
    add_column :users, :invitation_id, :integer
    add_column :users, :invitation_limit, :integer
  end
end
