ExtinctIn.Collections.Jobs = Backbone.Collection.extend({
  url: "api/experiences",
  model: ExtinctIn.Models.Job,

  initialize: function (options) {
    this.user = options.user
  },
})
