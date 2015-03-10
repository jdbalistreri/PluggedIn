ExtinctIn.Views.UserShow = Backbone.CompositeView.extend({

  template: JST["users/show"],

  events: {
    "submit .user-info-form" : "userInfoSubmit",
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);
    return this;
  },

  userInfoSubmit: function (event) {
    event.preventDefault();
  },
})
