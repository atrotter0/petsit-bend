module FormHelper
  def number_select_generator(start_value, end_value)
    value = start_value.upto(end_value)
    value.map{ |i| i }
  end
end