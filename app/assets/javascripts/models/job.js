ExtinctIn.Models.Job = Backbone.Model.extend({
  urlRoot: "api/experiences",

  initialize: function (options) {
    this.user = options.user
  },

})
