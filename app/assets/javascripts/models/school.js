PluggedIn.Models.School = Backbone.Model.extend({
  urlRoot: "api/experiences",

  initialize: function (options) {
    this.set("experience_type", 1);
  },

  toJSON: function () {
    return {experience: _.clone(this.attributes)}
  },

})
