ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.sent_connections = options.sent_connections;
    this.received_connections = options.received_connections;
    this.sent_messages = options.sent_messages;
    this.received_messages = options.received_messages;

    this.sent_connections.fetch();
    this.received_connections.fetch();
    this.sent_messages.fetch();
    this.received_messages.fetch();
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
    this.fillInbox(this.received_messages);
  },

  sentMessages: function () {
    this.fillInbox(this.sent_messages);
  },

  receivedConnections: function () {
    this.fillInbox(this.received_connections);
  },

  sentConnections: function () {
    this.fillInbox(this.sent_connections);
  },

  fillInbox: function (collection) {
    this.emptySubviews(".messages");

    if (collection instanceof ExtinctIn.Collections.Connections) {
      var viewConstructor = ExtinctIn.Views.ConnectionIndexItem;
    } else {
      var viewConstructor = ExtinctIn.Views.MessageIndexItem;
    }

    collection.each(function (model) {
      view = new viewConstructor({
        model: model,
      });
      this.addSubview(".messages", view);
    }.bind(this))


    if (this.subviews(".messages").length === 0) {
      this.$(".messages").html("Nothing new!");
    }
  },

})
