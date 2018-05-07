class ReservationMailer < ApplicationMailer
	def confirmation_email(user,host,reservation_id)
		@user = user
		@reservation_id = reservation_id
		@host = host
		@url  = 'localhost:3000/listings/:id/reservations/new'
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end

end
