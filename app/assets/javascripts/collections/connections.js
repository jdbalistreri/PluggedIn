ExtinctIn.Collections.Connections = Backbone.Collection.extend({

  model: ExtinctIn.Models.Connection,

  initialize: function (models, options) {
    this.user_id = options.user_id;
  },

  url: function () {
    return "api/users/" + this.user_id + "/connections";
  },

})

ExtinctIn.Collections.Connections.prototype.sent = function () {
  return this.where({sent: true});
};

ExtinctIn.Collections.Connections.prototype.received = function () {
  return this.where({sent: false});
};
