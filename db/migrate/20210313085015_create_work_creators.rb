class CreateWorkCreators < ActiveRecord::Migration[6.1]
  def change
    create_table :work_creators do |t|
      t.integer :role, default: 0, null: false
      t.boolean :guest, default: false, null: false
      t.string :name
      t.integer :xorder, default: 0, null: false
      t.references :creator, foreign_key: true, optional: true
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
