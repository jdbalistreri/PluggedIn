ExtinctIn.Models.School = Backbone.Model.extend({
  urlRoot: "api/experiences",

  initialize: function (options) {
    this.user = options.user;
    this.set("experience_type", 1);
  },

})
