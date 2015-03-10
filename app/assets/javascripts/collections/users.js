ExtinctIn.Collections.Users = Backbone.Collection.extend({
  url: "api/users",
  model: ExtinctIn.Models.User,

  getOrFetch: function (id) {
    var user = this.get(id);

    if (!user) {
      user = new ExtinctIn.Model.User({id: id});
      this.add(user)
    }

    user.fetch()

    return user;
  },
})
