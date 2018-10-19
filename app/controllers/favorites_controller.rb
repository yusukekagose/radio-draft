class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  skip_before_action :verify_authenticity_token

  def info
    @radio = Radio.find(params[:id])
    @count = Favorite.where(radio_id: @radio.id).count
  end

  def create
    user_id = current_user.id
    radio_id = params[:id]
    favorite = {user_id: user_id, radio_id: radio_id}
    @favorite = Favorite.new(favorite)

    if @favorite.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    if @favorite.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
end
