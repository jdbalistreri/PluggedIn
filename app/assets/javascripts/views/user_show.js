ExtinctIn.Views.UserShow = Backbone.CompositeView.extend({

  className: "user-show",
  tagName: "section",

  template: JST["users/show"],

  initialize: function () {
    this.connections = new ExtinctIn.Collections.Connections([], {user_id: this.model.id});
    this.connections.fetch();
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);

    this.addUserForm();
    this.addJobsIndex();
    this.addSchoolsIndex();
    this.addConnectedUsersIndex();

    return this;
  },

  addConnectedUsersIndex: function () {
    var connectedUsersIndex = new ExtinctIn.Views.ConnectedUsersIndex({
      collection: this.connections,
      user: this.model,
    });
    this.addSubview(".user-connections", connectedUsersIndex)
  },

  addJobsIndex: function () {
    var jobsIndex = new ExtinctIn.Views.ExperiencesIndex({
      collection: this.model.jobs(),
      user: this.model,
      typeU: "Job",
      typeL: "job",
    });
    this.addSubview(".user-experiences", jobsIndex);
  },

  addSchoolsIndex: function () {
    var schoolsIndex = new ExtinctIn.Views.ExperiencesIndex({
      collection: this.model.schools(),
      user: this.model,
      typeU: "School",
      typeL: "school",
    });
    this.addSubview(".user-experiences", schoolsIndex);
  },

  addUserForm: function () {
    var userForm = new ExtinctIn.Views.UserForm({
      model: this.model,
      connections: this.connections,
    });
    this.addSubview(".user-card", userForm);
  },
})
