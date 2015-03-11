ExtinctIn.Views.JobForm = Backbone.View.extend({

  tagName: "li",
  className: "new-job-form",


  template: JST["jobs/form"],

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },
})
