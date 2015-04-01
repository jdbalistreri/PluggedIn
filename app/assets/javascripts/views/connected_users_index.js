PluggedIn.Views.ConnectedUsersIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["connected_users/index"],

  initialize: function (options) {
    this.user = options.user;

    this.searchResults = new PluggedIn.Collections.ConnectionsSearch();
    this.no_event_search();
    this.listenTo(this.searchResults, "sync", this.render);
    this.listenTo(this.user, "sync", this.no_event_search);
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

    this.$el.html(content);
    this.emptySubviews("ul.connected-users-list");

    this.searchResults.each( function(user) {
      var connectionView = new PluggedIn.Views.UserIndexItem({model: user});
      this.addSubview("ul.connected-users-list", connectionView);
    }.bind(this))

    return this;
  },

  search: function (local_event, attr, shared) {
    if (this.user.get(attr) === undefined) return;

    local_event && local_event.preventDefault();
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

  all_search: function (local_event) {
    this.search(local_event, "num_connections", false);
  },

  no_event_search: function () {
    this.search(null, "num_connections", false);
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
