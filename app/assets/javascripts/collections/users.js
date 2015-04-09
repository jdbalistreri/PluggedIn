PluggedIn.Collections.Users = Backbone.Collection.extend({
  url: "api/users",
  model: PluggedIn.Models.User,

  comparator: "full_name",

  getOrFetch: function (id) {
    var user = this.get(id);

    if (!user) {
      user = new PluggedIn.Models.User({id: id});
      this.add(user);
    }

    user.fetch();

    return user;
  },
});
