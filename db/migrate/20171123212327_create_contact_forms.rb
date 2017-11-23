class CreateContactForms < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_forms do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :message
      t.timestamps
    end
  end
end
