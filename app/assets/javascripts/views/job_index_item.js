ExtinctIn.Views.JobIndexItem = Backbone.ExperiencesForm.extend({

  className: "job-index-item",
  template: JST["jobs/index-item"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({job: this.model});
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
