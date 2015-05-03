PluggedIn.Collections.ConnectedUsers = Backbone.Collection.extend({
  url: "api/inbox/connected_users",
  model: PluggedIn.Models.User,

  comparator: "full_name",
});
