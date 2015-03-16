ExtinctIn.Views.UserIndexItem = Backbone.CompositeView.extend({

  tagName: "li",
  className: "user-index-item",

  template: JST["users/index-item"],

  render: function () {
    var content = this.template({user: this.model})
    this.$el.html(content);

    if (!this.currentUser()) {
      // debugger
      var connectButton = new ExtinctIn.Views.ConnectButton({
        user: this.model,
        model: this.model.cu_connection(),
      });
      this.addSubview(".button-holder", connectButton);
    }

    return this;
  },

  currentUser: function () {
    return ExtinctIn.currentUserId === parseInt(this.model.id);
  },


})
