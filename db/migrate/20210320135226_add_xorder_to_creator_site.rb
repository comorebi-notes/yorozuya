class AddXorderToCreatorSite < ActiveRecord::Migration[6.1]
  def change
    add_column :creator_sites, :xorder, :integer, default: 0, null: false
  end
end
