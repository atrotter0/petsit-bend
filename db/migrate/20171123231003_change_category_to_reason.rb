class ChangeCategoryToReason < ActiveRecord::Migration[5.0]
  def change
    rename_column :leads, :category, :reason
  end
end
