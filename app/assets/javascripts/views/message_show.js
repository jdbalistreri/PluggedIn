ExtinctIn.Views.MessageShow = Backbone.CompositeView.extend({

  tagName: "li",
  className: "message-show",
  template: JST["messages/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({message: this.model});
    this.$el.html(content);

    if (this.model.user()) {
      var connectButton = new ExtinctIn.Views.ConnectButton({
        user: this.model.user(),
        model: this.model.user().cu_connection(),
      });
      this.addSubview(".button-holder", connectButton);
    }

    return this;
  },

})
