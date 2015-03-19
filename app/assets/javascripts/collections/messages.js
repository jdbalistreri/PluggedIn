ExtinctIn.Collections.Messages = Backbone.Collection.extend({

  initialize: function(models, options) {
    this.inbox = options.inbox;
  },

  model: ExtinctIn.Models.Message,

  comparator: function (model) {
    -model.get("created_at");
  },

  getOrFetch: function (id) {
    var model = this.get(id);

    if (!model) {
      model = new ExtinctIn.Models.Message({id: id});
      this.add(model);
    }

    model.fetch();

    return model;
  }
});


ExtinctIn.Collections.Messages.prototype.sent = function () {
  return this.where({sent: true});
};

ExtinctIn.Collections.Messages.prototype.received = function () {
  return this.where({sent: false});
};
