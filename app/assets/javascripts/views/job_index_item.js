ExtinctIn.Views.JobIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "job-index-item",

  template: JST["jobs/index-item"],

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

})
