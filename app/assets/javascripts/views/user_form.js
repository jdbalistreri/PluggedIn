ExtinctIn.Views.UserForm = Backbone.View.extend({

  template: JST["users/form"],

  events: {
    "submit form" : "userInfoSubmit",
    "dblclick p.trigger" : "toggleUserInfo",
    "click a.cancel" : "cancelForm",
  },

  render: function() {
    var content = this.template({user: this.model});
    this.$el.html(content);
    return this;
  },

  cancelForm: function () {
    this.toggleUserInfo();
    this.render();
  },

  toggleUserInfo: function () {
    if (ExtinctIn.currentUserId === this.model.id) {
      this.$el.toggleClass("toggled");
    }
  },

  userInfoSubmit: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = $(event.target).serializeJSON().user

    this.model.save(attrs, {
      success: function () {
        that.toggleUserInfo()
      },
    })
  },

})
