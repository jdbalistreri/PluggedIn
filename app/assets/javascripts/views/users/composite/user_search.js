ExtinctIn.Views.UserSearch = Backbone.CompositeView.extend({

  tagName: "article",
  className: "user-search group",

  initialize: function (options) {
    this.canSearch = true;
    this.page = 1;
    this.scrollMax = 440;
    this.query = options.query;
    this.searchResults = new ExtinctIn.Collections.SearchResults();
    this.searchResults.fetch({data: {query: this.query}});
    this.listenTo(this.searchResults, "sync", this.render);
  },

  template: JST["users/search"],

  events: {
    "submit form" : "search",
  },

  render: function () {
    if (this.subviews(".search-results").length > 0) {
      this.addResults();
      return;
    }
    var content = this.template({
      query: this.query,
      found: this.searchResults.found,
      totalCount: this.searchResults.totalCount});
    this.$el.html(content);

    $(".search-results").scroll(this.handleScroll.bind(this));
    this.addResults();

    return this;
  },

  addResults: function () {
    this.searchResults.each(function (user) {
      var indexItem = new ExtinctIn.Views.UserIndexItem({model: user});
      this.addSubview(".search-results", indexItem);
    }.bind(this))
  },

  search: function (event) {
    event && event.preventDefault();
    var query = this.$(".search-input").val();

    this.searchResults.fetch({
      data: {
        query: this.query,
        page: this.page
      },
      success: function () {
        this.canSearch = true;
      }.bind(this),
    });
  },

  handleScroll: function (event) {
    console.log(this.$(".user-index-item").length)
    // debugger
    if (event.currentTarget.scrollTop >= this.scrollMax && this.canSearch) {
      this.page += 1;
      this.scrollMax += 750;
      this.canSearch = false;
      this.search();
    }
    // debugger
  },
})
