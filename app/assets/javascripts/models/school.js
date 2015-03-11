ExtinctIn.Models.School = Backbone.Model.extend({
  urlRoot: "api/experiences",

  initialize: function (options) {
    this.user = options.user
  },

})
