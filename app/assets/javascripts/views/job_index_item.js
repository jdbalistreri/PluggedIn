ExtinctIn.Views.JobIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "job-index-item",

  template: JST["jobs/index-item"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "dblclick .trigger" : "toggleJobInfo",
    "submit form" : "editJobSubmit",
    "click a.cancel" : "cancelForm",
    "click a.delete" : "deleteJob",
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

  cancelForm: function () {
    this.toggleJobInfo();
    this.render();
  },

  deleteJob: function () {
    this.model.destroy();
  },

  editJobSubmit: function (event) {
    event.preventDefault();
    var that = this;

    var $ul = this.$(".errors")
    $ul.empty();

    var attrs = $(event.target).serializeJSON().experience;

    this.model.save(attrs, {
      success: function (model) {
        that.toggleJobInfo();
      },
      error: function (model, response) {
        response.responseJSON.forEach(function (error) {
          var $li = $("<li>").text(error);
          $ul.append($li);
        })
      },
    });
  },

  toggleJobInfo: function () {
    if (ExtinctIn.currentUserId === this.model.get("user_id")) {
      this.$el.toggleClass("toggled");
    }
  },

})
