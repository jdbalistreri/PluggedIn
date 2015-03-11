ExtinctIn.Views.UserShow = Backbone.CompositeView.extend({

  className: "user-show",
  tagName: "section",

  template: JST["users/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);

    this.addUserForm();
    this.addJobsIndex();

    return this;
  },

  addJobsIndex: function () {
    var jobsIndex = new ExtinctIn.Views.JobsIndex({
      collection: this.model.jobs(),
      user: this.model,
    })
    this.addSubview(".user-experiences", jobsIndex)
  },

  addUserForm: function () {
    var userForm = new ExtinctIn.Views.UserForm({
      model: this.model,
    })
    this.addSubview(".user-info", userForm)
  },
})
