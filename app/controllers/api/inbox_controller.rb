class Api::InboxController < ApplicationController

  def index
    @sent_messages = current_user.sent_messages.includes(:receiver)
    @received_messages = current_user.received_messages.includes(:sender)
    @received_connections = current_user.received_connections.where(status: 0).includes(:sender)
    @sent_connections = current_user.sent_connections.includes(:receiver)
  end

end
