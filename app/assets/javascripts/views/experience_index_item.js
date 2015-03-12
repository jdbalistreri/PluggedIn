ExtinctIn.Views.ExperienceIndexItem = Backbone.ExperiencesForm.extend({

  className: "experience-index-item",

  template: function () {
    return JST[this.type + "s/index-item"]
  },

  initialize: function (options) {
    this.type = options.type;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template()({experience: this.model});
    this.$el.html(content);

    this.selectCurrentDates()

    return this;
  },

  submitBeforeSave: function () {
    delete this.model.attributes["check_present"];
  },

  submitOnSuccess: function () {
    this.toggleEl();
    this.model.collection.sort();
  },
})
