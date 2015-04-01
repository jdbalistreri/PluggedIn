PluggedIn.Collections.Messages = Backbone.Collection.extend({

  initialize: function(models, options) {
    this.inbox = options.inbox;
  },

  model: PluggedIn.Models.Message,

  comparator: function (model) {
    return -Date.parse(model.get("created_at"));
  },

  getOrFetch: function (id) {
    var model = this.get(id);

    if (!model) {
      model = new PluggedIn.Models.Message({id: id});
      this.add(model);
    }

    model.fetch();

    return model;
  }
});


PluggedIn.Collections.Messages.prototype.sent = function () {
  return this.where({sent: true});
};

PluggedIn.Collections.Messages.prototype.received = function () {
  return this.where({sent: false});
};
