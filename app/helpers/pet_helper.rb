module PetHelper
  def pet_previous_reservations
    #@pet.user.reservations.where('pet_list ILIKE ?', "%#{@pet.name%}")
    @pet.user.reservations.where(Reservation.arel_table[:pet_list].matches("%#{@pet.name}%")).order("start_date ASC")
  end

  def pet_names_for_user(user)
    pets = user.pets.map{ |pet| pet.name }
    if pets.count > 1  
      pets = pets.join(', ')
    else
      pets = pets.first
    end
    pets
  end
end