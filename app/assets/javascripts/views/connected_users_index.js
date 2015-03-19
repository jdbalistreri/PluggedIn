ExtinctIn.Views.ConnectedUsersIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["connected_users/index"],

  initialize: function (options) {
    this.user = options.user;
    this.searchResults = new ExtinctIn.Collections.ConnectionsSearch();
    this.all_search();
    this.listenTo(this.searchResults, "sync", this.render);
  },

  events: {
    "click .next-page" : "nextPage",
    "click .prev-page" : "prevPage",
  },

  render: function () {
    var show_next = !(this.searchResults.pageNum >= this.searchResults.maxPages);
    var show_prev = !(this.searchResults.pageNum <= 1);

    var content = this.template({
      user: this.user,
      show_next: show_next,
      show_prev: show_prev,
    })

    this.$el.html(content)

    this.searchResults.each( function(user) {
      var connectionView = new ExtinctIn.Views.UserIndexItem({model: user});
      this.addSubview("ul.connected-users-list", connectionView);
    }.bind(this))

    return this;
  },

  search: function (event, attr, shared) {
    event && event.preventDefault();
    this.searchResults.pageNum = 1;
    this.searchResults.maxPages = Math.ceil(this.user.get(attr)/6);
    this.searchResults.fetch({
      data: {
        user_id: this.user.id,
        page: 1,
        shared: shared
      }
    });
  },

  all_search: function (event) {
    this.search(event, "num_connections", false);
  },

  nextPage: function (event) {
    if (this.searchResults.pageNum >= this.searchResults.maxPages) return;
    this.incrementSearch(1);
  },

  prevPage: function (event) {
    if (this.searchResults.pageNum <= 1) return;
    this.incrementSearch(-1);
  },

  incrementSearch: function (num) {
    this.searchResults.fetch({
      data: {
        user_id: this.user.id,
        page: this.searchResults.pageNum + num
      },
      success: function () {
        this.searchResults.pageNum = this.searchResults.pageNum + num;
      }.bind(this),
    })
  },

})
