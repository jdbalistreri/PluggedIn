ExtinctIn.Collections.Connections = Backbone.Collection.extend({

  model: ExtinctIn.Models.Connection,

  initialize: function (models, options) {
    this.user_id = options.user_id
  },

  url: function () {
    return "api/users/" + this.user_id + "/connections";
  },

})
