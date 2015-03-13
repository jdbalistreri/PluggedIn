ExtinctIn.ToggleableFormView = Backbone.CompositeView.extend({

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
    var that = this;
    this.$(".errors").empty();
    this.$("button").html("Submitting...").prop("disabled", true);

    this.submitBeforeSave();
    if (this.submitCancelCondition()) return;

    this.model.save(attrs, {
      success: function (model, response) {
        this.$("button").html("Submit").prop("disabled", false);
        return that.submitOnSuccess(response);
      },
      error: function (model, response) {
        this.$("button").html("Submit").prop("disabled", false);
        return that.submitOnError(response);
      },
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

  submitOnError: function (response) {
    response.responseJSON.forEach(function (error) {
      var $li = $("<li>").text(error);
      this.$(".errors").append($li);
    })
  },

})
