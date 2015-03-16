ExtinctIn.Views.ConnectedUsersIndex = Backbone.CompositeView.extend({

  tagName: "section",

  template: JST["connected_users/index"],

  initialize: function (options) {
    this.user = options.user;
    this.searchResults = new ExtinctIn.Collections.ConnectionsSearch();
    this.search();
    this.listenTo(this.searchResults, "sync", this.render);
  },

  events: {
    "click .next-page" : "nextPage",
    "click .prev-page" : "prevPage",
  },

  render: function () {
    var content = this.template()
    this.$el.html(content)

    this.searchResults.each( function(user) {
      var connectionView = new ExtinctIn.Views.UserIndexItem({model: user});
      this.addSubview("ul.connected-users-list", connectionView);
    }.bind(this))

    return this;
  },

  search: function (event) {
    event && event.preventDefault();
    this.searchResults.pageNum = 1;
    this.searchResults.fetch({
      data: {
        user_id: this.user.id,
        page: 1
      }
    });
  },

  nextPage: function (event) {
    this.incrementSearch(1);
  },

  prevPage: function (event) {
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
