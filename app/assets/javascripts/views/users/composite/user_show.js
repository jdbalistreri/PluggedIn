ExtinctIn.Views.UserShow = ExtinctIn.UserView.extend({

  className: "user-show",
  tagName: "section",

  template: JST["users/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    $(window).on("scroll", this.handleScroll.bind(this))
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);

    this.addUserCard();
    if (this.showJobs()) { this.addJobsIndex() };
    this.addSchoolsIndex();
    this.addConnectedUsersIndex();

    return this;
  },

  addConnectedUsersIndex: function () {
    var connectedUsersIndex = new ExtinctIn.Views.ConnectedUsersIndex({
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

  addUserCard: function () {
    var userCard = new ExtinctIn.Views.UserCard({
      model: this.model,
    });
    this.addSubview(".user-card", userCard);
  },

  showJobs: function () {
    return (this.model.jobs().length > 0) || this.currentUser();   ;
  },

  handleScroll: function (event) {
    if ($(document).scrollTop() >= 48) {
      this.$(".user-connections").addClass("absolute");
      this.$(".user-connections").css("top", $(document).scrollTop() - 48);
    } else {
      this.$(".user-connections").removeClass("fixed");
      this.$(".user-connections").removeAttr("style");
    }
  },

  remove: function () {
    ExtinctIn.UserView.prototype.remove.call(this);
  }
})
