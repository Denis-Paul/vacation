require 'rails_helper'

RSpec.describe DestinationsController, type: :controller do

    let(:valid_destination_attributes) {
        { :city => 'San Francisco', :country => 'USA', :currency => 'USD' }
    }

    let(:invalid_destination_attributes) {
        { :city => 'San Francisco', :country => '', :currency => 'USDT' }
    }

    let!(:destination_data) { create(:destination) }

    describe 'Destinations /index' do
        before(:each) do
            get :index
        end

        it 'renders the index template' do
            expect(response).to render_template('index')
        end

        it 'assigns all destinations to @destinations' do
            expect(assigns(:destinations)).to eq(Destination.all)
        end
    end

    describe 'Destinations /create' do
        context 'with valid parameters' do
            it 'creates a new destination' do
                expect {
                    post :create, params: { destination: valid_destination_attributes }
                }.to change(Destination, :count).by(1)
            end
      
            it 'redirects to the created destination' do
                destinations_url(destination: valid_destination_attributes)
                expect(response).to be_successful
            end
        end
      
        context 'with invalid parameters' do
            it 'does not create a new destination' do
                expect {
                    post :create, params: { destination: invalid_destination_attributes } 
                }.to_not change(Destination, :count)
            end
        end
    end

    describe 'Destinations /destroy' do
        it "deletes destination" do
            expect {
                delete :destroy, params: { id: destination_data.id, city: destination_data.city, country: destination_data.country, currency: destination_data.currency } 
            }.to change(Destination, :count).by(-1)
        end
    end
end