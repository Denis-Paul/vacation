require 'rails_helper'

RSpec.describe Destination, type: :model do
    let!(:destination_data) { create(:destination) }

    describe 'validations' do
        context 'city' do
            it { is_expected.to validate_presence_of(:city) }
            it { is_expected.to validate_uniqueness_of(:city) }
        end

        context 'country' do
            it { is_expected.to validate_presence_of(:country) }
        end

        context 'currency' do
            it { is_expected.to validate_presence_of(:currency) }
            it { is_expected.to validate_length_of(:currency).is_at_most(3).with_message("doesn't have a valid size") }
        end
    end
end