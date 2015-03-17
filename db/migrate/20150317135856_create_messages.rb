class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false, index: true
      t.integer :receiver_id, null: false, index: true
      t.string :subject, null: false
      t.text :body, null: false
      t.integer :reply_to_id
      
      t.timestamps
    end
  end
end
