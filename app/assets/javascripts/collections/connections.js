ExtinctIn.Collections.Connections = Backbone.Collection.extend({

  model: ExtinctIn.Models.Connection,

  initialize: function (models, options) {
    this.user_id = options.user_id;
    this.sent = options.sent;
    this.received = options.received;
  },

  url: function () {
    if (this.sent) {
      return "api/connections/sent";
    } else if (this.received) {
      return "api/connections/received";
    } else {
      return "api/users/" + this.user_id + "/connections";
    }
  },

})
