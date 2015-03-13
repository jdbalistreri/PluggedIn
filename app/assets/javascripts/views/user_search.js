ExtinctIn.Views.UserSearch = Backbone.View.extend({

  initialize: function () {
    this.searchResults = new ExtinctIn.Collections.SearchResults();
    this.listenTo(this.searchResults, "sync", this.render)
  },

  template: JST["users/search"],

  events: {
    "submit form" : "search",
  },

  render: function () {
    var content = this.template({results: this.searchResults});
    this.$el.html(content);
    return this;
  },

  search: function (event) {
    event.preventDefault();
    var query = this.$(".search-input").val();

    this.searchResults.fetch({
      data: {
        query: query
      },
    });
  },
})
