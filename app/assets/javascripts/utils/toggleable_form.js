Backbone.ToggleableFormView = Backbone.CompositeView.extend({

  events: {
    "click a.cancel" : "cancelForm",
    "click section.trigger" : "toggleEl",
    "click a.delete" : "deleteModel",
    "submit form" : "formSubmit",
  },

  cancelForm: function () {
    this.toggleEl();
    this.render();
  },

  deleteModel: function () {
    var modalView = new ExtinctIn.Views.DeleteModal({model: this.model})
    ExtinctIn.$modalEl.toggleClass("toggled");
    ExtinctIn.$modalEl.html(modalView.render().$el);
  },

  formSubmit: function (event) {
    event.preventDefault();
    var attrs = this.submitSetAttrs(event);
    this.$(".errors").empty();

    this.submitBeforeSave();
    if (this.submitCancelCondition()) return;

    this.model.save(attrs, {
      success: this.submitOnSuccess.bind(this),
      error: this.submitOnError.bind(this),
    })
  },

  toggleEl: function () {
    this.$el.toggleClass("toggled");
  },

  submitSetAttrs: function (event) {
    return $(event.target).serializeJSON();
  },

  submitCancelCondition: function () {
    return false;
  },

  submitBeforeSave: function () {},

  submitOnSuccess: function () {},

  submitOnError: function (model, response) {
    response.responseJSON.forEach(function (error) {
      var $li = $("<li>").text(error);
      this.$(".errors").append($li);
    })
  },

})
