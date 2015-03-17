ExtinctIn.Views.MessageShow = Backbone.View.extend({

  tagName: "li",
  template: JST["messages/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.model.id;
    this.$el.html(content);
    return this;
  },

})
