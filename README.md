# MyWeather

Take home assignment for Craftmanship Academy.

## Task
I was given the task of making a weather website that can look at multiple locations using ruby on rails. The minimum requirements of this:

- Create multiple locations by (IP Address and/or text address)
  *   ActiveRecord backed models
- View the 7-day forecast for each location
  * highlighting High and Low temps for each day
- Bonus #1: Chart the highs/lows
- Bonus #2: Leveraging Stimulus/Turbo for some of the CRUD interactions
- Bonus #3: deploy the application to a PaaS such as Heroku, Render.com, or Fly
  
While I would have liked to do more than the bare minimum, I simply just ran out of time.

## How to Run
1. You will need to install:
- Ruby version: `ruby 3.2.2`
- Rails version: `Rails 7.0.5`

2. Clone the repository and run:
```
$ bundle install
```
3. Start the server:
```
$ rails s
```
  This should generate some text indicating that it is working. If it is working the last 3 lines should look like this:
```
* Listening on http://[::1]:3000
* Listening on http://127.0.0.1:3000
Use Ctrl-C to stop
```

4. Go to your web browser and type `http://localhost:3000/` and you should be greeted with the home page. Here you should expect to see your current location.
5. To add more locations just sign in/sign up and click New Locations. These locations will be added to the dropdown menu labeled Locations. If the menu does not open just refresh the page.

## Testing

You did ask that I write some tests, so I did. I did not write tests for the whole program, but I had some basic ones for the locations model and its controller.

I used rspec for testing per your recommendation:
```
gem 'rspec-rails', '~> 4.0.1'
```

To run these tests:
```
$ bundle exec rspec
```
To view the model tests go to `spec/controllers/location_spec.rb`. The tests written on the model verifies that the model can save data and proves it does not save data for non-existent users.

To view the controller tests go to `spec/controllers/locations_controller_spec.rb`. The tests written on controller verify the right pages are loaded when calling `:index` and `:new`. They also verify the location exists or are spelled close enough that the geocoding API can find where the user is looking before the information is saved in the model. 
