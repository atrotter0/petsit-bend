class AddCategoryToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :category, :string
  end
end
