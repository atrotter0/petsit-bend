class AddBreedToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :breed, :string
  end
end
