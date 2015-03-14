ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.connections = options.connections;
  },

  template: JST["inbox/show"],

  events: {
    "click .received-connections" : "receivedConnections"
  },

  render: function (){
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  receivedConnections: function () {
    console.log("clicked")
    this.connections.each(function (connection) {
      view = new ExtinctIn.Views.ConnectionIndexItem({model: connection});
      this.addSubview(".messages", view);
    }.bind(this))
  },

})
