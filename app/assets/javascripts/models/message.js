PluggedIn.Models.Message = Backbone.Model.extend({

  urlRoot: "api/messages",

  parse: function (response) {
    if (response.user) {
      this.user(response.user);
      delete response.user;
    }

    return response;
  },

  user: function (attrs) {
    if (attrs) {
      this._user = new PluggedIn.Models.User(attrs, {parse: true});
    }
    return this._user;
  },

});
