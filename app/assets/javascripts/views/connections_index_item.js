ExtinctIn.Views.ConnectionIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "connection-index-item",

  template: JST["connections/index-item"],

  render: function () {
    var content = this.template({connection: this.model});
    this.$el.html(content);
    return this;
  },


})
