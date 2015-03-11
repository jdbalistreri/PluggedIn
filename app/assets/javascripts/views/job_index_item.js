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
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

  editJobSubmit: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = $(event.target).serializeJSON().experience;

    this.model.save(attrs, {
      success: function (model) {
        that.toggleJobInfo();
      }
    });
  },

  toggleJobInfo: function () {
    if (ExtinctIn.currentUserId === this.model.get("user_id")) {
      this.$el.toggleClass("toggled");
    }
  },

})
