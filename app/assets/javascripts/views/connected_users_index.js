ExtinctIn.Views.ConnectedUsersIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["connected_users/index"],

  initialize: function (options) {
    this.user = options.user;
    this.listenTo(this.collection, "sync add", this.render);
  },

  render: function () {
    var content = this.template()
    this.$el.html(content)

    this.collection.each( function(connection) {
      if (connection.get("status") !== "approved") return;
      var connectionView = new ExtinctIn.Views.UserIndexItem({model: connection.user()});
      this.addSubview("ul.connected-users-list", connectionView);
    }.bind(this))

    return this;
  },

})
