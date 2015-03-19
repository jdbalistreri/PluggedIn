ExtinctIn.Collections.Connections = Backbone.Collection.extend({

  model: ExtinctIn.Models.Connection,
  
  comparator: function (model) {
    -model.get("created_at");
  },

  initialize: function (models, options) {
    this.user_id = options.user_id;
  },

})

ExtinctIn.Collections.Connections.prototype.sent = function () {
  return this.where({sent: true});
};

ExtinctIn.Collections.Connections.prototype.received = function () {
  return this.where({sent: false});
};
