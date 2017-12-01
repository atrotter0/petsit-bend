module UserHelper
  def full_user_name(object)
    "#{object.user.first_name} #{object.user.last_name}"
  end

  def all_pets_for_users
    pet_list = []
    User.all.each do |user|
      user.pets.each do |pet|
        pet_list << "#{pet.name}, user id: #{user.id}"
      end
    end
    pet_list
  end

  def user_name_and_id(user)
    return "#{user.first_name} #{user.last_name}, user id: #{user.id}"
  end

  def create_pet_list
    # we need to clean up pet_list if admin creates the reservation
    # admin pet_list comes across as: pet_list => ["Frankie, user id: 2", "Orange, user id: 2"]
    params[:pet_list] = remove_user_ids(params[:pet_list]) if params[:pet_list].first.include?(',')
    if params[:pet_list].count > 1
      list = params[:pet_list].map{ |pet| "#{pet}" }.join(", ")
    else
      list = params[:pet_list].first
    end
    @reservation.pet_list = list
  end

  def remove_user_ids(pet_list)
    pet_list.each do |item|
      pet_list[pet_list.index(item)] = item.split(',').first
    end
    pet_list
  end

  def get_user_id
    return current_user.id unless params[:user_list].present?

    user_id = get_selected_user_id(params[:user_list])
  end

  def get_selected_user_id(user_list)
    # we need to get and set the user_id if admin creates the reservation
    # admin user_list comes across as: user_list = ["Abe Test, user id: 2"]
    user_list.first.split(':').last.strip!
  end
end
