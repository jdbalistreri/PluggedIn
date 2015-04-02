PluggedIn.Views.Header = Backbone.View.extend({

  className: "global-header",

  initialize: function () {
    this.model = new PluggedIn.Models.User({id: PluggedIn.currentUserId})
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "submit .header-search": "goToSearch",
  },

  template: JST["utils/header"],

  render: function () {
    var content = this.template({current_user: this.model});
    this.$el.html(content);
    return this;
  },

  goToSearch: function (event) {
    event.preventDefault();
    var query = $(event.currentTarget).serializeJSON().query;
    Backbone.history.navigate("#search?query=" + query, {trigger: true});
  },

})
