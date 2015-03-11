ExtinctIn.Models.Job = Backbone.Model.extend({
  urlRoot: "api/experiences",

  initialize: function (options) {
    this.set("experience_type", 0);
  },

})
