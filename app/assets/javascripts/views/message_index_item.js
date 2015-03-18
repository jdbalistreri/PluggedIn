ExtinctIn.Views.MessageIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "message-index-item",
  template: JST["messages/index-item"],

  render: function () {
    var content = this.template({message: this.model});
    this.$el.html(content);
    return this;
  },

})
