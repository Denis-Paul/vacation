class Destination < ApplicationRecord
    validates :city, presence: true, uniqueness: true
    validates :country, presence: true
    validates :currency, presence: true, length: { maximum: 3, message: "doesn't have a valid size" }

    scope :filter_by_country, ->(query) { where(["lower(country) LIKE ?", "%#{query.downcase}%"]) }

    def self.filter(query)
        filter_by_country(query)
    end
end
