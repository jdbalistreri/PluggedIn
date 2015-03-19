ExtinctIn.Views.ConnectionIndexItem = Backbone.CompositeView.extend({

  tagName: "li",
  className: "connection-index-item",

  template: JST["connections/index-item"],

  render: function () {
    var content = this.template({connection: this.model});
    this.$el.html(content);

    var connectButton = new ExtinctIn.Views.ConnectButton({
      user: this.model.user(),
      model: this.model.user().cu_connection(),
    });
    this.addSubview(".button-holder", connectButton);


    return this;
  },


})
