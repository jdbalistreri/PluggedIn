PluggedIn.Collections.Connections = Backbone.Collection.extend({

  model: PluggedIn.Models.Connection,

  comparator: function (model) {
    return -Date.parse(model.get("created_at"));
  },

  initialize: function (models, options) {
    this.user_id = options.user_id;
  },

});

PluggedIn.Collections.Connections.prototype.sent = function () {
  return this.where({sent: true});
};

PluggedIn.Collections.Connections.prototype.received = function () {
  return this.where({sent: false});
};
