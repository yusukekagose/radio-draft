class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :favorites]
  before_action :set_user, only: [:show, :toggle_status, :favorites]
  before_action :authorize_user, only: [:show, :favorites]
  before_action :set_counts, only: [:show, :favorites, :info]

  def show
    @drafts = current_user.drafts
  end

  def info
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(current_user_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Failed to update..."
    end
    redirect_to info_user_path(current_user)
  end

  def favorites
    radio_ids = Favorite.where(user_id: current_user.id).pluck(:radio_id)
    @radios = Radio.find(radio_ids)
  end

  def toggle_status
    if @user.secret?
      @user.open!
      redirect_to request.referrer
    elsif @user.open?
      @user.secret!
      redirect_to request.referrer
    end
  end

  private

    def current_user_params
      params.require(:user).permit(:radio_name, :address, :postal_code)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_counts
      @count_drafts = current_user.drafts.count
      @count_favorites = Favorite.where(user_id: current_user.id).count
    end

    def authorize_user
      if User.where(id: params[:id]).present?
        @user = User.find(params[:id])
        redirect_to root_url unless current_user == @user
      else
        redirect_to root_url
      end
    end
end
