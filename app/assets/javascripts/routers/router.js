ExtinctIn.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.connected_users = new ExtinctIn.Collections.Users();
    this.connected_users.fetch();

    this.inbox = new ExtinctIn.Models.Inbox();
    // this.inbox.fetch();

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

  bindEvents: function () {
    $(window).bind("mousewheel", this.handleScroll.bind(this));
    $(".header-search").on("submit", this.goToSearch.bind(this));
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

  goToSearch: function (event) {
    event.preventDefault();
    var query = $(event.currentTarget).serializeJSON().query;
    Backbone.history.navigate("#search?query=" + query, {trigger: true});
  },

  search: function (query) {
    var query = query ? query.split("=")[1] : ""
    var view = new ExtinctIn.Views.UserSearch({query: query});
    this._swapViews(view);
  },

  message_show: function (id) {
    message = this.inbox.messages().getOrFetch(id);

    var view = new ExtinctIn.Views.InboxShow({
      subview: new ExtinctIn.Views.MessageShow({model: message}),
      title: "Message Detail",
    });
    this._swapViews(view);
  },

  new_message: function (query) {
    var view = new ExtinctIn.Views.InboxShow({
      subview: new ExtinctIn.Views.MessageForm({
        query: query,
        model: new ExtinctIn.Models.Message(),
        collection: this.inbox.messages(),
        users: this.connected_users,
      }),
      title: "New Message",
    });
    this._swapViews(view);
  },

  inbox_show: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "messages",
      direction: "received",
      title: "Received Messages",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  sent_messages: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "messages",
      direction: "sent",
      title: "Sent Messages",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  received_messages: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "messages",
      direction: "received",
      title: "Received Messages",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  sent_connections: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "connections",
      direction: "sent",
      title: "Sent Connections",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  received_connections: function () {
    var view = new ExtinctIn.Views.InboxShow({
      type: "connections",
      direction: "received",
      title: "Received Connections",
      inbox: this.inbox,
    });
    this._swapViews(view);
  },

  user_show: function (id) {
    if (!id) {
      id = ExtinctIn.currentUserId;
    }
    var user = this.connected_users.getOrFetch(id);
    var view = new ExtinctIn.Views.UserShow({model: user});
    this._swapViews(view);
  },

  _swapViews: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },

})
