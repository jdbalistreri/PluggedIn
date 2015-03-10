class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :fname
      t.string :lname
      t.string :location
      t.string :tagline
      t.string :industry
      t.date :date_of_birth
      t.text :summary
    end

    add_index :profiles, :user_id, unique: true
  end
end
