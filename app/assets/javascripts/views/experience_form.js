ExtinctIn.Views.ExperienceForm = Backbone.ExperiencesForm.extend({

  className: "new-experience-form",

  template: function () {
    return JST[this.type + "s/new-form"]
  },

  initialize: function (options) {
    this.type = options.type;
  },

  render: function () {
    var content = this.template()({experience: this.model});
    this.$el.html(content);
    return this;
  },

  submitOnSuccess: function (model) {
    this.collection.add(model, {merge: true});
  },
})
