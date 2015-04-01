window.PluggedIn = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(options) {
    new PluggedIn.Routers.Router(options);
    Backbone.history.start();
    if (options.tour) {
      PluggedIn.Tour.start();
    }
  }
};
