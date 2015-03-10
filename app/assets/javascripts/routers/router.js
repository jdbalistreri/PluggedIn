ExtinctIn.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl
  },

  routes: {
    "": "index"
  },

  index: function () {
    this.$rootEl.html("hello")
  },


})
