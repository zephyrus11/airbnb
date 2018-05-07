class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(customer, host,reservation_id)
    # Do something later
    ReservationMailer.confirmation_email(customer,host,reservation_id).deliver_now
  end
end
