ExtinctIn.Views.ExperiencesIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["experiences/index"],

  initialize: function (options) {
    this.user = options.user;
    this.type = options.type;
    this.listenTo(this.collection, "add sort remove", this.render)
  },

  render: function () {
    var that = this;
    var content = this.template({type: this.type})
    this.$el.html(content)

    this.collection.each( function(experience) {
      var viewType = that.type + "IndexItem"
      var experienceItemView = new ExtinctIn.Views[viewType]({model: experience});
      that.addSubview("ul.experiences-list", experienceItemView);
    })

    if (ExtinctIn.currentUserId === this.user.id ) {
      var model = new ExtinctIn.Models[that.type]({user: this.user});

      var viewType = this.type + "Form"
      var newExperienceView = new ExtinctIn.Views[viewType]({model: model, collection: this.collection});

      this.addSubview("ul.experiences-list", newExperienceView);
    }

    return this;
  },

})
