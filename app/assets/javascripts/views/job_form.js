ExtinctIn.Views.JobForm = Backbone.ExperiencesForm.extend({

  className: "new-job-form",
  template: JST["jobs/new-form"],

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

  submitOnSuccess: function (model) {
    this.collection.add(model, {merge: true});
  },
})
