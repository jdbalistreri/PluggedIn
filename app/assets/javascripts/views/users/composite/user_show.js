PluggedIn.Views.UserShow = PluggedIn.UserView.extend({

  className: "user-show",
  tagName: "section",

  template: JST["users/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    $(window).on("scroll", this.handleScroll.bind(this));
  },

  render: function () {
    var content = this.template({user: this.model});
    this.$el.html(content);

    this.addUserCard();
    if (this.showJobs()) { this.addJobsIndex(); }
    this.addSchoolsIndex();
    this.addConnectedUsersIndex();

    return this;
  },

  addConnectedUsersIndex: function () {
    if (!this.connectedUsersIndex) {
      this.connectedUsersIndex = new PluggedIn.Views.ConnectedUsersIndex({
        user: this.model,
      });
    }
    this.addSubview(".user-connections", this.connectedUsersIndex);
  },

  addJobsIndex: function () {
    var jobsIndex = new PluggedIn.Views.ExperiencesIndex({
      collection: this.model.jobs(),
      user: this.model,
      typeU: "Job",
      typeL: "job",
    });
    this.addSubview(".user-experiences", jobsIndex);
  },

  addSchoolsIndex: function () {
    var schoolsIndex = new PluggedIn.Views.ExperiencesIndex({
      collection: this.model.schools(),
      user: this.model,
      typeU: "School",
      typeL: "school",
    });
    this.addSubview(".user-experiences", schoolsIndex);
  },

  addUserCard: function () {
    var userCard = new PluggedIn.Views.UserCard({
      model: this.model,
    });
    this.addSubview(".user-card", userCard);
  },

  showJobs: function () {
    return (this.model.jobs().length > 0) || this.currentUser();
  },

  handleScroll: function (event) {

    if (!this._documentHeight) {
      this._documentHeight = $(document).height();
    }

    if ($(document).scrollTop() >= 48) {
      this.$(".user-connections").addClass("absolute");
      if ($(document).scrollTop() + 673 > this._documentHeight) {
        this.$(".user-connections").css("top", this._documentHeight - (673+48));
      } else {
        this.$(".user-connections").css("top", $(document).scrollTop() - 48);
      }
    } else {
      this.$(".user-connections").removeClass("absolute");
      this.$(".user-connections").removeAttr("style");
    }
  },

  remove: function () {
    PluggedIn.UserView.prototype.remove.call(this);
  }
});
