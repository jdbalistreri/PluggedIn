class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.integer :status

      t.timestamps
    end

    add_index :connections, :sender_id
    add_index :connections, :receiver_id
  end
end
