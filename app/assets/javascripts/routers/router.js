ExtinctIn.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = new ExtinctIn.Collections.Users();
    this.collection.fetch();

    this.sent_connections = new ExtinctIn.Collections.Connections([], {user_id: ExtinctIn.currentUserId, sent: true});
    this.sent_connections.fetch();
    this.received_connections = new ExtinctIn.Collections.Connections([], {user_id: ExtinctIn.currentUserId, received: true});
    this.received_connections.fetch();
  },

  routes: {
    "": "index",
    "users/:id": "user_show",
    "inbox": "inbox_show",
  },

  index: function () {
    var view = new ExtinctIn.Views.UserSearch();
    this._swapViews(view);
  },

  inbox_show: function () {
    var view = new ExtinctIn.Views.InboxShow({
      sent_connections: this.sent_connections,
      received_connections: this.received_connections,
    });
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
