class Review < ApplicationRecord
    validates :comment, length: { maximum: 200 }

    belongs_to :user
    belongs_to :destination
end
