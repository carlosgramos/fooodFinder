class LocationsController < ApplicationController
  # before the show action if session[:location] has value run session else assign value of params[search_location]
  before_action :save_location, only: :show
  before_action :save_coordinates, only: :show
  after_action  :clear_location, only: :index
  after_action  :clear_coordinates, only: :index

  def index
  end

  #1. The zip code or location given by the user in index.html.erb
  #   is loaded inside the params hash.
  #2. The Location model's get_lat_and_long method is called, and we pass it the
  #   params hash containting the user input

  def show
    location = params[:search_location] || session[:location]
    testing = Geocoder.search(location)
    if testing.empty?
      redirect_to root_path
    else
    coordinates = params[:lat_lon] || session[:lat_lon]
    radius = params[:radius]
    # puts "Radius in controller #{radius}"
    if location != nil && coordinates != nil
      @locations = Location.get_search_results(location, coordinates, radius)
    else
      render 'index'
    end
  end
end

end
