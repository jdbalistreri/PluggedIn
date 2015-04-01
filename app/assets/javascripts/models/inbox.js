PluggedIn.Models.Inbox = Backbone.Model.extend({

  urlRoot: "api/inbox",

  parse: function (response) {
    if (response.received_connections) {
      this.connections().add(response.received_connections, {parse: true, inbox: this});
      delete response.received_connections;
    }

    if (response.sent_connections) {
      this.connections().add(response.sent_connections, {parse: true, inbox: this});
      delete response.sent_connections;
    }

    if (response.received_messages) {
      this.messages().add(response.received_messages, {parse: true, inbox: this});
      delete response.received_messages;
    }

    if (response.sent_messages) {
      this.messages().add(response.sent_messages, {parse: true, inbox: this});
      delete response.sent_messages;
    }

    return response
  },

  connections: function () {
    if (!this._connections) {
      this._connections = new PluggedIn.Collections.Connections([], {user_id: PluggedIn.currentUserId});
    }

    return this._connections
  },

  messages: function () {
    if (!this._messages) {
      this._messages = new PluggedIn.Collections.Messages([], {user_id: PluggedIn.currentUserId});
    }

    return this._messages
  },

})
