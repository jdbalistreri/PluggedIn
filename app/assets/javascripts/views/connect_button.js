PluggedIn.Views.ConnectButton = Backbone.View.extend({

  template: JST["users/connect-button"],

  initialize: function (options) {
    this.user = options.user;
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .request-connection" : "requestConnection",
    "click .approve-connection" : "approveConnection",
    "click .deny-connection" : "denyConnection",
    "click .message-user" : "messageUser"
  },

  render: function () {
    var content = this.template({user: this.user,
                                  cu_connection: this.model});
    this.$el.html(content);
    return this;
  },

  approveConnection: function () {
    this.model.set("status", 1);
    this.model.save({}, {
      success: function (model) {
        var connection = PluggedIn.Inbox.connections().get(model.id);
        PluggedIn.Inbox.connections().remove(connection);
        this.user.set("num_connections", this.user.get("num_connections")+1);
      }.bind(this)
    });
  },

  denyConnection: function () {
    this.model.set("status", 2);
    this.model.save({}, {
      success: function (model) {
        var connection = PluggedIn.Inbox.connections().get(model.id);
        PluggedIn.Inbox.connections().remove(connection);
      },
    });
  },

  messageUser: function () {
    Backbone.history.navigate("#inbox/messages/new?user_id=" + this.user.id, {trigger: true});
  },

  requestConnection: function () {
    this.model.set("sender_id", PluggedIn.currentUserId);
    this.model.set("receiver_id", this.user.id);
    this.model.save({}, {
      success: function (model) {
        PluggedIn.Inbox.messages().add(model, {merge: true});
      },
    });

  },
});
