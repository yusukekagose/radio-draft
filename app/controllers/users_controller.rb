class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :favorites]
  before_action :set_counts, only: [:show, :favorites]

  def show
    @drafts = current_user.drafts
  end

  def favorites
    radio_ids = Favorite.where(user_id: current_user.id).pluck(:radio_id)
    @radios = Radio.find(radio_ids)
  end

  private
    def set_counts
      @count_drafts = current_user.drafts.count
      @count_favorites = Favorite.where(user_id: current_user.id).count
    end
end
