class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
  end

  def show
  end

  def new
  end

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = "マイクロポストをお気に入りに追加しました。"
    redirect_to micropost #user?
  end
  
  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = "マイクロポストのお気に入りを解除しました。"
    redirect_to micropost #user?
  end
end