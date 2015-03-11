ExtinctIn.Views.JobForm = Backbone.View.extend({

  tagName: "li",
  className: "new-job-form",


  template: JST["jobs/new-form"],

  events: {
    "submit form" : "newJobSubmit",
    "click a.trigger" : "toggleNewJob",
    "click a.cancel" : "cancelForm",
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

  cancelForm: function () {
    this.toggleNewJob();
    this.render();
  },

  newJobSubmit: function (event) {
    event.preventDefault();
    var that = this;

    var $ul = this.$(".errors")
    $ul.empty();

    var attrs = $(event.target).serializeJSON().experience

    this.model.save(attrs, {
      success: function () {
        that.collection.add(that.model);
        that.model.fetch();
      },
      error: function (model, response) {
        response.responseJSON.forEach(function (error) {
          var $li = $("<li>").text(error);
          $ul.append($li);
        })
      },
    })
  },

  toggleNewJob: function () {
    this.$el.toggleClass("toggled");
  },
})
