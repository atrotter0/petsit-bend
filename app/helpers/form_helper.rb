module FormHelper
  def number_select_generator(start_value, end_value)
    value = start_value.upto(end_value)
    value.map{ |i| i }
  end

  def hours_generator(start_value, end_value)
    start_value.upto(end_value)
  end

  def days_of_the_week
    ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"].freeze
  end
end
