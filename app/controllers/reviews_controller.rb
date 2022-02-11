class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ edit update destroy ]
  before_action :find_destination

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.destination_id = @destination.id
    @review.user_id = current_user.id
    # @destination.rating = @review.rating
    # @destination.save

    respond_to do |format|
      if @review.save
        format.html { redirect_to favorites_url, notice: "Review was successfully created." }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @destination.rating = @review.rating
    # @destination.save

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to favorites_url, notice: "Review was successfully updated." }
        format.json { render :show, status: :ok}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to favorites_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_destination
      @destination = Destination.find(params[:destination_id])
    end
end


    