class AddPetListToReservation < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :number_of_pets
    add_column :reservations, :pet_list, :string
  end
end
