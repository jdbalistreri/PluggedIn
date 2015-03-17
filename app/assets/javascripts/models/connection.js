ExtinctIn.Models.Connection = Backbone.Model.extend({

  urlRoot: "api/connections",

  parse: function (response) {
    if (response.user) {
      this.user(response.user);
      delete response.user;
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
