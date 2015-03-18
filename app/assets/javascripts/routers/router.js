ExtinctIn.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = new ExtinctIn.Collections.Users();
    this.collection.fetch();

    this.inbox = new ExtinctIn.Models.Inbox();
    this.inbox.fetch();

    this.bindEvents();
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

  bindEvents: function () {
    $(window).bind("mousewheel", this.handleScroll.bind(this));
  },

  handleScroll: function (event) {
    if (event.originalEvent.wheelDelta >= 0) {
      $(".global-header").removeClass("toggled")
    } else {
      $(".global-header").addClass("toggled")
    }
  },

  index: function () {
    var view = new ExtinctIn.Views.UserSearch();
    this._swapViews(view);
  },

  message_show: function (id) {
    message = this.inbox.messages().getOrFetch(id);

    var view = new ExtinctIn.Views.InboxShow({
      subview: new ExtinctIn.Views.MessageShow({model: message})
    });
    this._swapViews(view);
  },

  new_message: function (query) {
    var view = new ExtinctIn.Views.InboxShow({
      subview: new ExtinctIn.Views.MessageForm({
        query: query,
        model: new ExtinctIn.Models.Message(),
        collection: this.inbox.messages(),
        users: this.collection,
      })
    });
    this._swapViews(view);
  },

  inbox_show: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "messages",
      direction: "received",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  sent_messages: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "messages",
      direction: "sent",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  received_messages: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "messages",
      direction: "received",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  sent_connections: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "connections",
      direction: "sent",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  received_connections: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "connections",
      direction: "received",
      inbox: this.inbox,
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
