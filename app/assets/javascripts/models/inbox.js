ExtinctIn.Models.Inbox = Backbone.Model.extend({

  urlRoot: "api/inbox",

  parse: function (response) {
    if (response.received_connections) {
      this.received_connections().add(response.received_connections, {parse: true, inbox: this});
      delete response.received_connections;
    }

    if (response.sent_connections) {
      this.sent_connections().add(response.sent_connections, {parse: true, inbox: this});
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

  received_connections: function () {
    if (!this._received_connections) {
      this._received_connections = new ExtinctIn.Collections.Connections(
        [],
        {user_id: ExtinctIn.currentUserId, received: true}
      );
    }

    return this._received_connections
  },

  sent_connections: function () {
    if (!this._sent_connections) {
      this._sent_connections = new ExtinctIn.Collections.Connections(
        [],
        {user_id: ExtinctIn.currentUserId, sent: true}
      );
    }

    return this._sent_connections
  },

  messages: function () {
    if (!this._messages) {
      this._messages = new ExtinctIn.Collections.Messages([], {user_id: ExtinctIn.currentUserId});
    }

    return this._messages
  },

})
