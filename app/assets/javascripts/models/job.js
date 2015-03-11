ExtinctIn.Models.Job = Backbone.Model.extend({
  urlRoot: "api/experiences",

  initialize: function (options) {
    this.user = options.user;
    this.set("experience_type", 0);
  },

})
