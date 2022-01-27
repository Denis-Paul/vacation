class FavoritesController < ApplicationController
  def index
  end

  def create
    @destination = Destination.find(params[:id])
    @favorite = Favorite.create(user_id: current_user.id, destination_id: @destination.id) unless Favorite.exists?(destination_id: @destination.id)
  end

  def destroy
    @destination = Destination.find(params[:id])
    @favorite = Favorite.find_by(user_id: current_user.id, destination_id: @destination.id)
    @favorite.destroy
  end
end
