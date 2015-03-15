ExtinctIn.Views.ConnectedUsersIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["connected_users/index"],

  initialize: function (options) {
    this.user = options.user;
    this.collection = new ExtinctIn.Collections.Connections([], {user_id: this.user.id});
    this.collection.fetch();
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var content = this.template()
    this.$el.html(content)

    this.collection.each( function(connection) {
      var connectionView = new ExtinctIn.Views.UserIndexItem({model: connection.user()});
      this.addSubview("ul.connected-users-list", connectionView);
    }.bind(this))

    return this;
  },

})
