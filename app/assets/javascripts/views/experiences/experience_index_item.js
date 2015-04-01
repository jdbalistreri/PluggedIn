PluggedIn.Views.ExperienceIndexItem = Backbone.ExperiencesForm.extend({

  className: "experience-index-item",

  template: function () {
    return JST[this.type + "s/index-item"]
  },

  initialize: function (options) {
    this.type = options.type;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template()({experience: this.model, currentUser: this.currentUser()});
    this.$el.html(content);

    this.selectCurrentDates()

    return this;
  },

  currentUser: function () {
    return PluggedIn.currentUserId === parseInt(this.model.get("user_id"));
  },

  submitBeforeSave: function () {
    delete this.model.attributes["check_present"];
  },

  submitOnSuccess: function () {
    this.toggleEl();
    this.model.collection.sort();
  },
})
