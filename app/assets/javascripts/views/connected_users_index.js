ExtinctIn.Views.ConnectedUsersIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["connections/index"],

  initialize: function (options) {
    this.user = options.user;
    this.collection = new ExtinctIn.Collections.ConnectedUsers([], {user_id: this.user.id});
    this.collection.fetch();
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var content = this.template()
    this.$el.html(content)

    this.collection.each( function(user) {
      var connectionView = new ExtinctIn.Views.UserIndexItem({model: user});
      this.addSubview("ul.connections-list", connectionView);
    }.bind(this))

    return this;
  },

})
