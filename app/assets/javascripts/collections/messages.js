ExtinctIn.Collections.Messages = Backbone.Collection.extend({

  initialize: function(models, options) {
    this.contains_sent = options.contains_sent;
  },

  model: ExtinctIn.Models.Message,

  url: function () {
    if (this.contains_sent) {
      return "api/messages/sent";
    } else {
      return "api/messages/received";
    }
  },

})
