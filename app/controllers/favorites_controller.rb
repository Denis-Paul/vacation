class FavoritesController < ApplicationController
  before_action :set_favorites, only: %i[ index ]

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

  private

  def set_favorites
    @favorite_destinations = current_user.favorites
  end
end
