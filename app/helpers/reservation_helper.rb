module ReservationHelper
  def sort_by_date(reservations, user_id)
    sorted_list = []
    @date_list = get_string_dates(reservations)
    convert_sort_reformat_dates
    @final_date_list.each do |date|
      sorted_list << Reservation.where(start_date: date).where(user_id: user_id)
    end
    sorted_list
  end

  def get_string_dates(reservations)
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

  def convert_sort_reformat_dates
    convert_to_dates
    format_dates
    reformat_dates
  end

  def convert_to_dates
    @converted_list = []
    @date_list.each do |date|
      date = convert_to_date(date)
      @converted_list << date
    end
  end

  def format_dates
    @format_list = []
    @converted_list.each do |date|
      @format_list << year_month_day(date)
    end
    @format_list.sort!
  end

  def reformat_dates
    @final_date_list = []
    @format_list.each do |date|
      date = date.to_date
      date = month_day_year(date)
      @final_date_list << date
    end
  end

  def year_month_day(date)
    date = date.strftime('%Y/%m/%d')
  end

  def month_day_year(date)
    date = date.strftime('%m/%d/%Y')
  end

  def reservaton_user_name(reservation)
    "#{reservation.user.first_name} #{reservation.user.last_name}"
  end
end
