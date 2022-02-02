class AddRatingToDestinations < ActiveRecord::Migration[6.1]
  def change
    add_column :destinations, :rating, :integer, :default => 0
  end
end
