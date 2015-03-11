ExtinctIn.Views.JobsIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["jobs/index"],

  render: function () {
    var that = this;
    var content = this.template()
    this.$el.append(content)

    this.collection.each( function(job) {
      var jobItemView = new ExtinctIn.Views.JobIndexItem({model: job});
      that.addSubview("ul.jobs-list", jobItemView);
    })

    return this;
  },

})
