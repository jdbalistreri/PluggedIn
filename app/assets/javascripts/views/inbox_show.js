ExtinctIn.Views.InboxShow = Backbone.View.extend({

  template: JST["inbox/show"],

  render: function (){
    var content = this.template();
    this.$el.html(content);
    return this;
  },
})
