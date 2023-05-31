require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "saving data" do
    it "can save information" do
      user = FactoryBot.create(:user) #needs a user to save a table
      model = Location.new(city: "Gillett", state: "PA",zipcode: 16925, user_id: 1)

      expect(model.save).to be true
      expect(Location.count).to eq(1)
    end
    it "wont save information for non-existing users" do
      user = FactoryBot.create(:user)
      model = Location.new(city: "Gillett", state: "PA",zipcode: 16925, user_id: 2)

      expect(model.save).to be false
      expect(Location.count).to eq(0)
    end 
  end
end
