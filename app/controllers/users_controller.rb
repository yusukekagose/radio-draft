class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :favorites]
  before_action :set_user, only: [:show, :toggle_status, :favorites]
  before_action :authenticate_user!, only: [:show, :favorites]
  before_action :set_counts, only: [:show, :favorites]

  def show
    @drafts = current_user.drafts
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
