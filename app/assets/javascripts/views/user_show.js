ExtinctIn.Views.UserShow = Backbone.CompositeView.extend({

  className: "user-show",
  tagName: "section",

  template: JST["users/show"],

  events: {
    "submit .user-info > form" : "userInfoSubmit",
    "dblclick .user-info > p" : "toggleUserInfo",
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);

    this.addJobsIndex();

    return this;
  },

  toggleUserInfo: function () {
    if (ExtinctIn.currentUserId === this.model.id) {
      this.$(".user-info").toggleClass("toggled");
    }
  },

  userInfoSubmit: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = $(event.target).serializeJSON().user

    this.model.save(attrs, {
      success: function () {
        that.toggleUserInfo()
      },
    })
  },

  addJobsIndex: function () {
    var jobsIndex = new ExtinctIn.Views.JobsIndex({collection: this.model.jobs()})
    this.addSubview(".user-experiences", jobsIndex)
  },
})
