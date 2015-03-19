ExtinctIn.Collections.Users = Backbone.Collection.extend({
  url: "api/users",
  model: ExtinctIn.Models.User,

  comparator: "full_name",

  getOrFetch: function (id) {
    var user = this.get(id);

    if (!user) {
      user = new ExtinctIn.Models.User({id: id});
      this.add(user)
    }

    user.fetch()

    return user;
  },
});


// ExtinctIn.Collections.Users.prototype.connected_users = function () {
//   var connected_users = [];
//
//   this.each(function (user) {
//     if (user.cu_connection()) {
//       if (user.cu_connection().get("status") === "approved") {
//         connected_users.push(user);
//       }
//     }
//   })
//
//   return connected_users;
// };
