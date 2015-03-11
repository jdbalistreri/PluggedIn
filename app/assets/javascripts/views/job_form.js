ExtinctIn.Views.JobForm = Backbone.View.extend({

  tagName: "li",
  className: "new-job-form",


  template: JST["jobs/form"],

  events: {
    "submit form" : "newJobSubmit"
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

  newJobSubmit: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = $(event.target).serializeJSON().experience
    debugger
    this.model.save(attrs, {
      success: function () {
        that.collection.add(that.model);
      },
    })
  },
})
