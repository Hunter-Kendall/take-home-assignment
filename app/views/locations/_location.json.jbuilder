json.extract! location, :id, :city, :state, :zipcode, :created_at, :updated_at
json.url location_url(location, format: :json)
