PluggedIn.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.connected_users = new PluggedIn.Collections.Users();
    this.connected_users.fetch();

    PluggedIn.Inbox = new PluggedIn.Models.Inbox();

    this.$header = options.$header;
    this.addHeader();
    this.bindEvents();
  },

  routes: {
    "": "user_show",
    "users/:id": "user_show",
    "inbox": "inbox_show",
    "search": "search",
    "inbox/messages/sent": "sent_messages",
    "inbox/messages/received": "received_messages",
    "inbox/messages/new": "new_message",
    "inbox/messages/:id": "message_show",
    "inbox/connections/sent": "sent_connections",
    "inbox/connections/received": "received_connections",
  },

  addHeader: function () {
    this.headerView = new PluggedIn.Views.Header();
    this.$header.html(this.headerView.render().$el)
  },

  bindEvents: function () {
    $(window).bind("mousewheel", this.handleScroll.bind(this));
  },

  clearSearch: function () {
    this.headerView.clearSearch();
  },

  handleScroll: function (event) {
    if ($(document).scrollTop() === 0) {
      $(".global-header").removeClass("toggled");
      return;
    }

    if (event.originalEvent.wheelDelta >= 0) {
      $(".global-header").removeClass("toggled")
    } else {
      $(".global-header").addClass("toggled")
    }
  },

  search: function (query) {
    var query = query ? query.split("=")[1] : ""
    var view = new PluggedIn.Views.UserSearch({query: query});
    this._swapViews(view);
  },

  message_show: function (id) {
    this.clearSearch();
    message = PluggedIn.Inbox.messages().getOrFetch(id);

    var view = new PluggedIn.Views.InboxShow({
      subview: new PluggedIn.Views.MessageShow({model: message}),
      title: "Message Detail",
    });
    this._swapViews(view);
  },

  new_message: function (query) {
    this.clearSearch();
    var view = new PluggedIn.Views.InboxShow({
      subview: new PluggedIn.Views.MessageForm({
        query: query,
        model: new PluggedIn.Models.Message(),
        collection: PluggedIn.Inbox.messages(),
        users: this.connected_users,
      }),
      title: "New Message",
    });
    this._swapViews(view);
  },

  inbox_show: function () {
    this.clearSearch();
    var view = new PluggedIn.Views.InboxShow({
      type: "messages",
      direction: "received",
      title: "Received Messages",
      inbox: true,
    });
    this._swapViews(view);
  },

  sent_messages: function () {
    this.clearSearch();
    var view = new PluggedIn.Views.InboxShow({
      type: "messages",
      direction: "sent",
      title: "Sent Messages",
      inbox: true,
    });
    this._swapViews(view);
  },

  received_messages: function () {
    this.clearSearch();
    var view = new PluggedIn.Views.InboxShow({
      type: "messages",
      direction: "received",
      title: "Received Messages",
      inbox: true,
    });
    this._swapViews(view);
  },

  sent_connections: function () {
    this.clearSearch();
    var view = new PluggedIn.Views.InboxShow({
      type: "connections",
      direction: "sent",
      title: "Sent Connections",
      inbox: true,
    });
    this._swapViews(view);
  },

  received_connections: function () {
    this.clearSearch();
    var view = new PluggedIn.Views.InboxShow({
      type: "connections",
      direction: "received",
      title: "Pending Received Connections",
      inbox: true,
    });
    this._swapViews(view);
  },

  user_show: function (id) {
    this.clearSearch();
    if (!id) {
      id = PluggedIn.currentUserId;
    }
    var user = this.connected_users.getOrFetch(id);
    var view = new PluggedIn.Views.UserShow({model: user});
    this._swapViews(view);
  },

  _swapViews: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },

})
