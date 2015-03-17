ExtinctIn.Collections.Messages = Backbone.Collection.extend({

  initialize: function(models, options) {
    this.sent = options.sent;
  },

  model: ExtinctIn.Models.Message,

  url: function () {
    if (this.sent) {
      return "api/messages/sent";
    } else {
      return "api/messages/received";
    }
  },

})
