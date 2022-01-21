require 'rails_helper'

RSpec.describe Destination, type: :model do
    let!(:destination_data) { create(:destination) }

    describe 'validations' do
        context 'city' do
            it { should validate_presence_of(:city) }
            it { should validate_uniqueness_of(:city) }
        end

        context 'country' do
            it { should validate_presence_of(:country) }
        end

        context 'currency' do
            it { should validate_presence_of(:currency) }
            it { should validate_length_of(:currency).is_at_most(3).with_message("doesn't have a valid size") }
        end
    end
end