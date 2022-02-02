class HomeController < ApplicationController
  def index
    @destinations = Destination.all
    # @destinations = Destination.joins(:reviews).group("destinations.id").order("avg(reviews.rating) desc")
  end
end
