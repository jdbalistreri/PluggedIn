ExtinctIn.Models.Connection = Backbone.Model.extend({

  urlRoot: "api/connections",

  parse: function (response) {
    if (response.users) {
      this.user().set(response.users[0]);
      delete response.users;
    }

    return response
  },

  user: function () {
    if (!this._user) {
      this._user = new ExtinctIn.Models.User();
    }
    return this._user
  },

})
