PluggedIn.Views.Header = Backbone.View.extend({

  className: "global-header",

  initialize: function () {
    this.model = new PluggedIn.Models.User({id: PluggedIn.currentUserId})
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .logout" : "logout",
  },

  template: JST["utils/header"],

  render: function () {
    var content = this.template({current_user: this.model});
    this.$el.html(content);
    return this;
  },

  logout: function () {
    console.log("logout")
  },
})
