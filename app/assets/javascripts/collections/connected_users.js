ExtinctIn.Collections.ConnectedUsers = Backbone.Collection.extend({

  initialize: function (models, options) {
    this.user_id = options.user_id
  },

  url: function () {
    return "api/users/" + this.user_id + "/connected_users";
  },

  model: ExtinctIn.Models.User,
})
