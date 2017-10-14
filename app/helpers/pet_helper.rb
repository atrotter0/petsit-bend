module PetHelper
  def pet_previous_reservations
    @pet.user.reservations.where(Reservation.arel_table[:pet_list].matches("%#{@pet.name}%")).order("start_date ASC")
  end

  def pet_names_for_user(user)
    pets = user.pets.map{ |pet| pet.name }
    pets.count > 1 ? pets = pets.join(', ') : pets = pets.first
    pets
  end

  def sort_pets_by_user
    get_pet_users_and_sort
    list = build_sorted_pet_list
    list.flatten!.paginate(paginate_settings(6))
  end

  def get_pet_users_and_sort
    @pet_user_list = User.all.order("last_name ASC")
  end

  def build_sorted_pet_list
    sorted_pet_list = []
    @pet_user_list.each do |user|
      sorted_pet_list << user.pets
    end
    sorted_pet_list
  end
end
