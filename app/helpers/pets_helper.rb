module PetsHelper
  def pet_ages
    age = 1.upto(30)
    age.map{ |age| age }
  end
end
