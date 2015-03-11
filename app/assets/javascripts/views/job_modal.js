ExtinctIn.Views.JobModal = Backbone.View.extend({

  tagName: "section",

  template: JST["jobs/modal"],

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
  },

  toggleModal: function () {
    ExtinctIn.$modalEl.toggleClass("toggled");
  }
})
