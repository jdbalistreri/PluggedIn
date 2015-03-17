ExtinctIn.Views.MessageForm = Backbone.View.extend({

  tagName: "form",
  template: JST["messages/form"],

  events: {
    "submit" : "handleSubmit"
  },

  initialize: function (options) {
    this.users = options.users;
    this.query = options.query;
    this.listenTo(this.users, "sync", this.render)
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);

    this.users.connected_users().forEach(function (user) {
      var $option = $("<option>").html(user.escape("full_name")).attr("value", user.id);
      this.$(".user-select").append($option);
    }.bind(this))

    return this;
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var attrs = this.$el.serializeJSON();
    var that = this;

    this.model.save(attrs, {
      success: function (model, response) {
        this.collection.add(model, {merge: true});
        Backbone.history.navigate("#inbox/messages/" + model.id, {trigger: true});
      }.bind(this),
    })
  },

})
