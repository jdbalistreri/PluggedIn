PluggedIn.ToggleableFormView = Backbone.CompositeView.extend({

  events: {
    "click a.cancel" : "cancelForm",
    "click .trigger span.edit" : "toggleEl",
    "click a.delete" : "deleteModel",
    "submit form" : "formSubmit",
  },

  cancelForm: function () {
    this.toggleEl();
    this.render();
  },

  currentUser: function () {
    return PluggedIn.currentUserId === parseInt(this.model.id);
  },

  deleteModel: function () {
    var modalView = new PluggedIn.Views.DeleteModal({model: this.model})
    PluggedIn.$modalEl.toggleClass("toggled");
    PluggedIn.$modalEl.html(modalView.render().$el);
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
      }.bind(this),
      error: function (model, response) {
        this.$("button").html("Submit").prop("disabled", false);
        return that.submitOnError(response);
      }.bind(this),
    })
  },

  toggleEl: function () {
    if (!this.currentUser()) return;
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
      var $li = $("<li>").text(error).addClass("error");
      this.$(".errors").append($li);
    }.bind(this))
  },

})
