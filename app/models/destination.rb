class Destination < ApplicationRecord
    validates :city, presence: true, uniqueness: true
    validates :country, presence: true
    validates :currency, presence: true, length: { maximum: 3, message: "doesn't have a valid size" }

    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites
    has_many :reviews
end
