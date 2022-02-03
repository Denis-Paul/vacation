require 'rails_helper'

RSpec.describe DestinationsController, type: :controller do
    render_views

    let(:valid_destination_attributes) {
        { :city => 'San Francisco', :country => 'USA', :currency => 'USD' }
    }

    let(:invalid_destination_attributes) {
        { :city => 'San Francisco', :country => '', :currency => 'USDT' }
    }

    let!(:destination_data) { create(:destination) }

    describe 'Destinations /index' do
        before(:each) do
            get :index, :format => :json
        end

        it 'returns OK status' do
            # expect(response).to have_http_status(200)
            expect(response).to be_successful
        end

        it 'shows all destinations' do
            # body = JSON.parse(response.body)
            total = Destination.all.count
            expect(response.body).to match total.to_s
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
        it 'deletes destination, redirects to index and shows flash message' do
            expect {
                delete :destroy, params: { id: destination_data.id } 
            }.to change(Destination, :count).by(-1)
            expect(response).to redirect_to destinations_url
            expect(flash[:notice]).to eq('Destination was successfully destroyed.')
        end
    end
end