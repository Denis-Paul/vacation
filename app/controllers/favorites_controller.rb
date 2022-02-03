class FavoritesController < ApplicationController
  def index
  end

  def create
    @destination = Destination.find(params[:id])
    @favorite = Favorite.create(user: current_user, destination: @destination) unless Favorite.exists?(user: current_user, destination: @destination)
  end

  def destroy
    @destination = Destination.find(params[:id])
    @favorite = Favorite.find_by(user: current_user, destination: @destination)
    @favorite.destroy
  end
end
