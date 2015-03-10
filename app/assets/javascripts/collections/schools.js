ExtinctIn.Collections.Schools = Backbone.Collection.extend({
  url: "api/experiences",
  model: ExtinctIn.Models.School,

  initialize: function (options) {
    this.user = options.user
  },
})
