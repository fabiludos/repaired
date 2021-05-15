class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    authorize @booking
    # for geocode
    @customer_marker = {
        lat: 52.5200,
        lng: 13.4050
    }

    @mechanic_marker = {
        lat: 52.4125,
        lng: 12.5316
    }
    @markers = [@customer_marker, @mechanic_marker]

  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    if @booking.save!
      # for now redirect to homepage
      redirect_to root_path notice: 'Booking was successfully created'
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:location, :repair_id, :user_id, photos: [])
  end
end
