module ReservationHelper
  def sort_by_date(reservations, user_id)
    sorted_list = []
    date_list = get_dates(reservations).sort!
    date_list.each do |date|
      sorted_list << Reservation.where(start_date: date).where(user_id: user_id)
    end
    sorted_list
  end

  def get_dates(reservations)
    reservations.map{ |reservation| reservation.start_date }
  end
end
