ExtinctIn.Views.ConnectionIndexItem = Backbone.CompositeView.extend({

  tagName: "li",
  className: "connection-index-item",

  template: JST["connections/index-item"],

  render: function () {
    var content = this.template({connection: this.model});
    this.$el.html(content);
    var userIndexView = new ExtinctIn.Views.UserIndexItem({model: this.model.user()});
    this.addSubview(".user-detail", userIndexView);
    return this;
  },


})
