ExtinctIn.Views.ExperiencesIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["experiences/index"],

  initialize: function (options) {
    this.user = options.user;
    this.typeU = options.typeU;
    this.typeL = options.typeL;
    this.$el.addClass(this.typeL + "-section");
    this.listenTo(this.collection, "add sort remove", this.render)
  },

  render: function () {
    var that = this;
    var content = this.template({type: this.typeL})
    this.$el.html(content)

    this.collection.each( function(experience) {
      var experienceItemView = new ExtinctIn.Views.ExperienceIndexItem(
                                  {model: experience, type: that.typeL});
      that.addSubview("ul.experiences-list", experienceItemView);
    })

    if (ExtinctIn.currentUserId === this.user.id ) {
      var model = new ExtinctIn.Models[that.typeU]({user: this.user});

      var viewType = this.typeU + "Form"
      var newExperienceView = new ExtinctIn.Views.ExperienceForm(
        { model: model,
          collection: this.collection,
          type: this.typeL});

      this.addSubview("ul.experiences-list", newExperienceView);
    }

    return this;
  },

})
