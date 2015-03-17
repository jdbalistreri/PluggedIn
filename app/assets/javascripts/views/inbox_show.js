ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.connections = options.connections;
  },

  template: JST["inbox/show"],

  events: {
    "click .received-connections" : "receivedConnections",
    "click .sent-connections" : "sentConnections",
    "click .sent-messages" : "sentMessages",
    "click .received-messages" : "receivedMessages",
  },

  render: function (){
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  receivedMessages: function () {
    console.log("received");
  },

  sentMessages: function () {
    console.log('sent');
  },

  receivedConnections: function () {
    this.fillInbox(this.connections, "sender_id");
  },

  sentConnections: function () {
    this.fillInbox(this.connections, "receiver_id");
  },

  fillInbox: function (collection, id_attr) {
    this.emptySubviews(".messages");
    collection.each(function (model) {
      if (parseInt(model.get(id_attr)) === ExtinctIn.currentUserId) {
        return;
      }

      if (id_attr === "sender_id") {
        if (model.get("status") !== "pending") {
          return;
        }
      }

      view = new ExtinctIn.Views.ConnectionIndexItem({
        model: model,
      });
      this.addSubview(".messages", view);
    }.bind(this))

    if (this.subviews(".messages").length === 0) {
      this.$(".messages").html("Nothing new!");
    }
  },

})
