ExtinctIn.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = new ExtinctIn.Collections.Users();
    this.collection.fetch();

    this.sent_connections = new ExtinctIn.Collections.Connections([], {user_id: ExtinctIn.currentUserId, sent: true});
    this.received_connections = new ExtinctIn.Collections.Connections([], {user_id: ExtinctIn.currentUserId, received: true});
    this.sent_messages = new ExtinctIn.Collections.Messages([], {user_id: ExtinctIn.currentUserId, sent: true});
    this.received_messages = new ExtinctIn.Collections.Messages([], {user_id: ExtinctIn.currentUserId});
  },

  routes: {
    "": "index",
    "users/:id": "user_show",
    "inbox": "inbox_show",
    "inbox/messages/sent": "sent_messages",
    "inbox/messages/received": "received_messages",
    "inbox/messages/new": "new_message",
    "inbox/messages/:id": "message_show",
    "inbox/connections/sent": "sent_connections",
    "inbox/connections/received": "received_connections",
  },

  index: function () {
    var view = new ExtinctIn.Views.UserSearch();
    this._swapViews(view);
  },

  message_show: function (id) {
    message = this.sent_messages.get(id);

    if (!message) {
      message = this.received_messages.get(id);
    }

    var view = new ExtinctIn.Views.InboxShow({
      subview: new ExtinctIn.Views.MessageShow({
        model: message || new ExtinctIn.Models.Message()})
    });
    this._swapViews(view);
  },

  new_message: function (query) {
    var view = new ExtinctIn.Views.InboxShow({
      subview: new ExtinctIn.Views.MessageForm({
        query: query,
        model: new ExtinctIn.Models.Message(),
        collection: this.sent_messages
      })
    });
    this._swapViews(view);
  },

  inbox_show: function () {
    var view = new ExtinctIn.Views.InboxShow({
      collection: this.received_messages,
    });
    this._swapViews(view);
  },

  sent_messages: function () {
    var view = new ExtinctIn.Views.InboxShow({
      collection: this.sent_messages,
    });
    this.sent_messages.fetch();
    this._swapViews(view);
  },

  received_messages: function () {
    var view = new ExtinctIn.Views.InboxShow({
      collection: this.received_messages,
    });
    this.received_messages.fetch();
    this._swapViews(view);
  },

  sent_connections: function () {
    var view = new ExtinctIn.Views.InboxShow({
      collection: this.sent_connections,
    });
    this.sent_connections.fetch();
    this._swapViews(view);
  },

  received_connections: function () {
    var view = new ExtinctIn.Views.InboxShow({
      collection: this.received_connections,
    });
    this.received_connections.fetch();
    this._swapViews(view);
  },

  user_show: function (id) {
    var user = this.collection.getOrFetch(id);
    var view = new ExtinctIn.Views.UserShow({model: user});
    this._swapViews(view);
  },

  _swapViews: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },

})
