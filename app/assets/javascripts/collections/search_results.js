ExtinctIn.Collections.SearchResults = Backbone.Collection.extend({
  url: "api/search",
  model: ExtinctIn.Models.User,

  parse: function (response) {
    if (response.found) {
      this.found = response.found;
    }

    if (response.total_count) {
      this.totalCount = response.total_count;
    }

    return response.results
  },
})
