ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.sent_connections = options.sent_connections;
    this.received_connections = options.received_connections;
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
    this.fillInbox(this.received_connections);
  },

  sentConnections: function () {
    this.fillInbox(this.sent_connections);
  },

  fillInbox: function (collection) {
    this.emptySubviews(".messages");

    collection.each(function (model) {
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
