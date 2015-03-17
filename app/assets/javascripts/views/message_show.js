ExtinctIn.Views.MessageShow = Backbone.View.extend({

  tagName: "li",
  template: JST["messages/show"],

  render: function () {
    var content = this.model.id;
    this.$el.html(content);
    return this;
  },

})
