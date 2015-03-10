class DropProfileTable < ActiveRecord::Migration
  def change
    drop_table(:profiles)

    add_column(:users, :fname, :string)
    add_column(:users, :lname, :string)
    add_column(:users, :location, :string)
    add_column(:users, :tagline, :string)
    add_column(:users, :industry, :string)
    add_column(:users, :date_of_birth, :date)
    add_column(:users, :summary, :text)
  end
end
