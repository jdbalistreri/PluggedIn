ExtinctIn.Collections.Schools = Backbone.Collection.extend({
  url: "api/experiences",
  model: ExtinctIn.Models.School,

  initialize: function (models, options) {
    this.user = options.user;
  }

})
