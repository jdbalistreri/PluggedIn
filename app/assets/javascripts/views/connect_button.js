ExtinctIn.Views.ConnectButton = Backbone.View.extend({

  template: JST["users/connect-button"],

  render: function () {
    var content = this.template({user: this.model,
                                  cu_connection: this.model.cu_connection});
    this.$el.html(content);
    return this;
  }

})
