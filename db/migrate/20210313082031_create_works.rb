class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.string     :title,        null: false
      t.integer    :status,       null: false, default: 0
      t.string     :slug,         null: false, index: { unique: true }
      t.date       :release_date, null: false
      t.text       :description
      t.text       :content
      t.integer    :like,         null: false, default: 0
      t.references :work,         foreign_key: true

      t.timestamps
    end
  end
end
