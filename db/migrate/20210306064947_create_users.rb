class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name,            null: false
      t.string :screen_name,     null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :remember_token

      t.timestamps
    end
  end
end
