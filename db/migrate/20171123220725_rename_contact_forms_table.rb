class RenameContactFormsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :contact_forms, :leads
  end
end
