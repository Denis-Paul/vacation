class FavoritesController < ApplicationController
  before_action :set_favorites, only: %i[ index ]

  def index
    # @reviews = []
    # @favorite_destinations.each do |favorite|
    #   review_by_current_user = favorite.destination.reviews.where(:user_id == current_user.id)
    #   @reviews.push(review_by_current_user)
    # end
    
    # @sorted_destinations = @reviews.sort_by(&:rating) #sort_by{ |e| e[:rating] }.reverse
  end

  def create
    @destination = Destination.find(params[:id])
    @favorite = Favorite.create(user: current_user, destination: @destination) unless Favorite.exists?(user: current_user, destination: @destination)
  end

  def destroy
    @destination = Destination.find(params[:id])
    @favorite = Favorite.find_by(user: current_user, destination: @destination)
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to favorites_url, notice: "Favorite destination was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_favorites
    # @favorite_destinations = current_user.favorites
    @favorite_destinations = current_user.destinations.sort_by(&:city) # &:rating
    # @favorite_destinations = Destination.get_ordered_destinations(current_user.id) # TODO: get also the destinations without an added review
  end
end
