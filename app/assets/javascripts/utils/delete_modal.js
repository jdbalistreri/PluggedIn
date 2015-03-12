ExtinctIn.Views.DeleteModal = Backbone.View.extend({

  tagName: "section",

  template: JST["utils/delete-modal"],

  events: {
    "click a.no" : "toggleModal",
    "click a.yes" : "deleteModel"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  deleteModel: function () {
    this.model.destroy();
    this.toggleModal();
    this.remove();
  },

  toggleModal: function () {
    ExtinctIn.$modalEl.toggleClass("toggled");
    this.remove();
  }
})
