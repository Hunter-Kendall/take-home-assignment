require 'rails_helper'
require "devise"

RSpec.describe LocationsController, type: :controller do
    include Devise::Test::ControllerHelpers
    describe LocationsController do
        before do
            sign_in FactoryBot.create(:user)
        end
        describe "GET index" do
          it "renders the index template" do
            get :index
            expect(response).to render_template(:index)
          end
      
          it "assigns @locations with all locations" do
            
            location1 = Location.create(city: "Gillett", state: "Pa", zipcode: 16925, user_id: 1)
            location2 = Location.create(city: "troy", state: "Pa", zipcode: 16947, user_id: 1)
      
            get :index
            expect(assigns(:locations)).to match_array([location1, location2])
          end
        end
        describe "GET new" do
            it "renders the index template" do
                get :new
                expect(response).to render_template(:new)
            end
        end
        describe "POST create" do
          it "creates a new location" do

            post :create, params: { location: { city: "Gillett", state: "Pa", zipcode: 16925, user_id: 1 } }
            
            expect(Location.count).to eq(1)
          end

          it "does not create invalid locations"do

           post :create, params: { location: { city: "asdf", state: "ASDFASFDASD", zipcode: 1, user_id: 1 } }
           post :create, params: { location: { city: "", state: "",  user_id: 1 } }
           expect(Location.count).to eq(0)
          end

          it "redirects to the index page after creating a location" do
            post :create, params: { location: { city: "Gillett", state: "Pa", zipcode: 16925, user_id: 1 } }
            expect(response).to redirect_to(location_path(Location.last))
          end
        end
      end
      
end