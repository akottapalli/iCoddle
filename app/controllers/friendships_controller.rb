class FriendshipsController < ApplicationController
  def create
    if not current_user.friendships.where(:friend_id => params[:friend_id]).empty?
      redirect_to users_path, :notice => "Friend already in network"
    else
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      if @friendship.save
        redirect_to users_path, :notice => "Added friend"
      else
        redirect_to users_path, :notice => "Unable to add friend"
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to users_path, :notice => "Removed friend"
  end
end
