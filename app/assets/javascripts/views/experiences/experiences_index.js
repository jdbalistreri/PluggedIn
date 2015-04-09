PluggedIn.Views.ExperiencesIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["experiences/index"],

  initialize: function (options) {
    this.user = options.user;
    this.typeU = options.typeU;
    this.typeL = options.typeL;
    this.$el.addClass(this.typeL + "-section");
    this.listenTo(this.collection, "add sort remove", this.render);
  },

  render: function () {
    var that = this;
    var content = this.template({type: this.typeL});
    this.$el.html(content);

    this.collection.each( function(experience) {
      var experienceItemView = new PluggedIn.Views.ExperienceIndexItem(
                                  {model: experience, type: that.typeL});
      that.addSubview("ul.experiences-list", experienceItemView);
    });

    if (PluggedIn.currentUserId === this.user.id ) {
      var model = new PluggedIn.Models[that.typeU]({user: this.user});

      var viewType = this.typeU + "Form";
      var newExperienceView = new PluggedIn.Views.ExperienceForm(
        { model: model,
          collection: this.collection,
          type: this.typeL});

      this.addSubview("ul.experiences-list", newExperienceView);
    }

    return this;
  },

});
