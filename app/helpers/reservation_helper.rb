module ReservationHelper
  def setup_sort_paginate(user_id, paginate_limit)
    sort_by_date(user_id).flatten!.paginate(paginate_settings(paginate_limit))
  end

  def sort_by_date(user_id)
    @date_list = get_dates_from_reservations
    convert_sort_reformat_dates
    sorted_list = return_sorted_date_list(user_id)
  end

  def get_dates_from_reservations
    list = @reservations.map{ |reservation| reservation.start_date }
    list.uniq! if list.count > 1
    list
  end

  def petsit_started?(start_date)
    convert_to_date(start_date) <= Date.today
  end

  def petsit_finished?(end_date)
    convert_to_date(end_date) <= Date.today.end_of_day
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

  def return_sorted_date_list(user_id)
    sorted_list = []
    @final_date_list.each do |date|
      if user_id == 'admin'
        sorted_list << Reservation.where(start_date: date)
      else
        sorted_list << Reservation.where(start_date: date).where(user_id: user_id)
      end
    end
    sorted_list
  end
end
