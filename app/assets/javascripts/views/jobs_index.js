ExtinctIn.Views.JobsIndex = Backbone.View.extend({

  tagName: "ul",
  className: "jobs-index",

  render: function () {
    this.$el.empty();
    // this.collection.each( function(job) {
    //
    // })
    this.$el.html("jobsindexworks");
    return this;
  },

})
