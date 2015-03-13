window.ExtinctIn = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(options) {
    new ExtinctIn.Routers.Router(options);
    if (!Backbone.History.started) {
      Backbone.history.start();
    }
  }
};
