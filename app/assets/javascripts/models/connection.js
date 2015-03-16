ExtinctIn.Models.Connection = Backbone.Model.extend({

  urlRoot: "api/connections",

  parse: function (response) {
    if (response.users) {
      this.user(response.users[0]);
      delete response.users;
    }

    return response
  },

  user: function (attrs) {
    if (attrs) {
      this._user = new ExtinctIn.Models.User(attrs, {parse: true});
    }
    return this._user
  },

})
