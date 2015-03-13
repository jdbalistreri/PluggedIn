ExtinctIn.Views.UserIndexItem = Backbone.View.extend({

  template: JST["users/index-item"],

  render: function () {
    var content = this.template({user: this.model})
    this.$el.html(content);
    return this;
  },


})
