class Api::InboxController < ApplicationController
  before_action :require_logged_in
  
  def index
    @sent_messages = current_user.sent_messages.includes(receiver: :connections)
    @received_messages = current_user
                         .received_messages
                         .includes(sender: :connections)
    @received_connections = current_user
                            .received_connections
                            .where(status: 0)
                            .includes(sender: :connections)
    @sent_connections = current_user
                        .sent_connections
                        .includes(receiver: :connections)
  end
end
