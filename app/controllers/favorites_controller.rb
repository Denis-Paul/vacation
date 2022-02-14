class FavoritesController < ApplicationController
  before_action :set_favorites, only: %i[ index ]

  def index
    # @reviews = []
    # @favorite_destinations.each do |favorite|
    #   review_by_current_user = favorite.destination.reviews.where(:user_id == current_user.id)
    #   @reviews.push(review_by_current_user)
    # end
    
    # @sorted_destinations = @reviews.sort_by(&:rating) #sort_by{ |e| e[:rating] }.reverse
    # @destinations = Destination.all
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
    # @favorite_destinations = current_user.destinations.sort_by(&:city) # &:rating
    @ordered_dest_list = []
    favorites_ids = current_user.destinations.collect(&:id)
    # @favorite_destinations = Destination.get_ordered_destinations(current_user.id) # TODO: get also the destinations without an added review # destinatins_ids
    destinations_with_rating = Destination.get_ordered_destinations(current_user.id).ids # collect(&:id)
    favorite_destinations = (destinations_with_rating + favorites_ids).uniq
    # TODO: implement a more efficient way of creating the ordered list of favorite destinations 
    favorite_destinations.each do |dest_id|
        destination = Destination.find(dest_id)
        @ordered_dest_list.push(destination)
    end
  end
end
