ExtinctIn.Views.ConnectButton = Backbone.View.extend({

  template: JST["users/connect-button"],

  initialize: function (options) {
    this.user = options.user;
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .request-connection" : "requestConnection",
    "click .approve-connection" : "approveConnection",
    "click .deny-connection" : "denyConnection"
  },

  render: function () {
    var content = this.template({user: this.user,
                                  cu_connection: this.model});
    this.$el.html(content);
    return this;
  },

  approveConnection: function () {
    this.model.set("status", 1)
    this.model.save();
  },

  denyConnection: function () {
    this.model.set("status", 2)
    this.model.save();
  },

  requestConnection: function () {
    this.model.set("sender_id", ExtinctIn.currentUserId)
    this.model.set("receiver_id", this.user.id)
    this.model.save();
  },

})
