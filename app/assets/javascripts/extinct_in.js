window.ExtinctIn = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(options) {
    new ExtinctIn.Routers.Router(options);
    Backbone.history.start();
    if (options.tour) {
      ExtinctIn.Tour.start();
    }
  }
};
