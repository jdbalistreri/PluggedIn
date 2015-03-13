class AddUniquenessValidationToUserConnections < ActiveRecord::Migration
  def change
    add_index(:user_connections, [:connection_id, :user_id], unique: true)
  end
end
