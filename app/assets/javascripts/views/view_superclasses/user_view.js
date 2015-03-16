ExtinctIn.UserView = Backbone.CompositeView.extend({

  render: function() {
    var content = this.template({user: this.model, currentUser: this.currentUser()});
    this.$el.html(content);

    if (!this.currentUser()) {
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
  
});
