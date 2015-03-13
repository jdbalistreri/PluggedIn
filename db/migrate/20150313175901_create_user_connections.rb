class CreateUserConnections < ActiveRecord::Migration
  def change
    create_table :user_connections do |t|
      t.integer :user_id, null: false, index: true
      t.integer :connection_id, null: false, index: true
    end
  end
end
