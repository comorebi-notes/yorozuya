class CreateCreatorSites < ActiveRecord::Migration[6.1]
  def change
    create_table :creator_sites do |t|
      t.string :name, null: false
      t.integer :kind, default: 0, null: false
      t.string :url, null: false
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
