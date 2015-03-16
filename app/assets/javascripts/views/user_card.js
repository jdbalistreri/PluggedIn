ExtinctIn.Views.UserCard = ExtinctIn.ToggleableFormView.extend({

  template: JST["users/card"],

  render: function() {
    var content = this.template({user: this.model, currentUser: this.currentUser()});
    this.$el.html(content);

    var userProfileShow = new ExtinctIn.Views.UserProfileShow({model: this.model});
    this.addSubview(".user-info", userProfileShow);

    if (this.currentUser()) {
      var userForm = new ExtinctIn.Views.UserForm({model: this.model});
      this.addSubview(".user-form", userForm);
    }

    return this;
  },

  currentUser: function () {
    return ExtinctIn.currentUserId === parseInt(this.model.id);
  },

})
