ExtinctIn.Views.ConnectionIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "connection-index-item",

  render: function () {
    var content = "connection index item";
    this.$el.html(content);
    return this;
  },


})
