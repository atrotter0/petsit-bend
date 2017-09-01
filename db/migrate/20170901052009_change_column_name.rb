class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :pets, :type, :pet_type
  end
end
