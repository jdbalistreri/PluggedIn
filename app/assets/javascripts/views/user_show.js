ExtinctIn.Views.UserShow = Backbone.CompositeView.extend({

  className: "user-show",

  template: JST["users/show"],

  events: {
    "submit .user-info-form" : "userInfoSubmit",
    "dblclick .user-info" : "toggleDisplay",
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);
    return this;
  },

  toggleDisplay: function () {
    this.$el.toggleClass("toggled");
  },

  userInfoSubmit: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = $(event.target).serializeJSON().user

    this.model.save(attrs, {
      success: function () {
        that.toggleDisplay()
      },
    })
  },
})
