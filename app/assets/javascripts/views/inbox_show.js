ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.connections = options.connections;
  },

  template: JST["inbox/show"],

  events: {
    "click .received-connections" : "receivedConnections",
    "click .sent-connections" : "sentConnections"
  },

  render: function (){
    var content = this.template();
    this.$el.html(content);
    return this;
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
      view = new ExtinctIn.Views.ConnectionIndexItem({
        model: model,
      });
      this.addSubview(".messages", view);
    }.bind(this))
  },

})
