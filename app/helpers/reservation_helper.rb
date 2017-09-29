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

  def petsit_started?(start_date)
    convert_to_date(start_date) <= Date.today
  end

  def petsit_finished?(end_date)
    convert_to_date(end_date) <= Date.today
  end

  def convert_to_date(date_string)
    Date.strptime(date_string, '%m/%d/%Y').to_date
  end
end
