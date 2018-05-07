class ReservationsController < ApplicationController
	def new
		
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new

		
	end

	def create

        @listing = Listing.find(params[:id])
        @reserve = Reservation.new(reservation_params)
        
        if date_checker(@reserve.start_date, @reserve.end_date)

            @reserve.save
            ReservationJob.perform_now(current_user,@reserve.listing.user,@reserve.id)
            redirect_to '/braintree/new/'+params[:id]
            flash[:notice] = "Booking has been confirmed."
        else
            redirect_to reservations_new_path
        end

    end

     def date_checker(start_date,end_date)
        @reservation = Reservation.where("listing_id = ?" , params[:id])
        if @reservation
           
            @reservation.each do |r|
               
                if     !(r.end_date <= start_date || r.start_date >= end_date)
                        flash[:notice] ="Sorry, dates has been taken."
                    return false
                end
            end
        else
            return true
        end
    end

    private

    def reservation_params
        params.require(:reservations).permit(:user_id, :listing_id, :guest_number, :start_date, :end_date)
    end
end


