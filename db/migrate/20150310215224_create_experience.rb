class CreateExperience < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id, null: false
      t.integer :experience_type, null: false
      t.string :role
      t.string :institution
      t.string :location
      t.text :description
      t.date :start_date, null: false
      t.date :end_date
      t.string :field
    end

    add_index :experiences, :user_id
    add_index :experiences, :experience_type
  end
end
