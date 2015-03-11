ExtinctIn.Views.JobsIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["jobs/index"],

  initialize: function (options) {
    this.user = options.user;
  },

  render: function () {
    var that = this;
    var content = this.template()
    this.$el.append(content)

    this.collection.each( function(job) {
      var jobItemView = new ExtinctIn.Views.JobIndexItem({model: job});
      that.addSubview("ul.jobs-list", jobItemView);
    })

    if (ExtinctIn.currentUserId === this.user.id ) {
      var model = new ExtinctIn.Models.Job({user: this.user});
      var newJobView = new ExtinctIn.Views.JobForm({model: model});
      this.addSubview("ul.jobs-list", newJobView);
    }

    return this;
  },

})
