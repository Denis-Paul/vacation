class Destination < ApplicationRecord
    validates :city, presence: true, uniqueness: true
    validates :country, presence: true
    validates :currency, presence: true, length: { maximum: 3, message: "doesn't have a valid size" }

    attribute :weather, array: true

    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites
    has_many :reviews

    attribute :weather, array: true

    scope :filter_by_country, ->(query) { where(["lower(country) LIKE ?", "%#{query.downcase}%"]) }

    def self.filter(query)
        filter_by_country(query)
    end

    # scope :get_ordered_by_rating, ->(user_id) { includes(:reviews, :favorites).all.where("reviews.user_id = ? OR favorites.user_id = ?", user_id, user_id).order('reviews.rating DESC NULLS LAST') } 
    # includes(:reviews, :favorites).select('reviews.id','favorites.id').order('reviews.rating ASC')
    scope :ordered_by_rating, ->(query) { joins(:reviews).where("reviews.user_id = :id", id: query).order('reviews.rating DESC NULLS LAST') }
    # scope :ordered_by_rating, ->(user_id, ids) { includes(:reviews).where("reviews.user_id = :id || favorites.destination_id = :ids", id: user_id, ids: ids).order('reviews.rating DESC NULLS LAST') }

    def self.get_ordered_destinations(user)
        ordered_by_rating(user)
    end
end
