class FavoritesController < ApplicationController
  before_action :set_favorites, only: %i[ index ]

  def index
  end

  def create
    @destination = Destination.find(params[:id])
    @favorite = Favorite.create(user_id: current_user.id, destination_id: @destination.id) unless Favorite.exists?(destination_id: @destination.id, user_id: current_user.id)
  end

  def destroy
    @destination = Destination.find(params[:id])
    @favorite = Favorite.find_by(user_id: current_user.id, destination_id: @destination.id)
    @favorite.destroy
  end

  private

  def set_favorites
    @favorite_destinations = current_user.favorites
  end
end
