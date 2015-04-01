PluggedIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.inbox = options.inbox;
    this.subview = options.subview;
    this.type = options.type;
    this.title = options.title;
    this.direction = options.direction;


    if (this.inbox) {
      PluggedIn.Inbox.fetch();
      this.updateValues();
      this.listenTo(PluggedIn.Inbox, "sync", this.updateValues);
      this.listenTo(PluggedIn.Inbox.connections(), "remove", this.updateValues);
    }
  },

  template: JST["inbox/show"],

  render: function (){
    var content = this.template({title: this.title, count: this.displayItems && this.displayItems.length});
    this.$el.html(content);

    if (this.subview) {
      this.addSubview(".messages", this.subview)
    } else {
      this.fillInbox();
    }

    return this;
  },

  updateValues: function () {
    this.displayItems = PluggedIn.Inbox[this.type]()[this.direction]();
    this.render();
  },

  fillInbox: function () {

    if (this.displayItems[0] instanceof PluggedIn.Models.Connection) {
      var viewConstructor = PluggedIn.Views.ConnectionIndexItem;
    } else {
      var viewConstructor = PluggedIn.Views.MessageIndexItem;
    }

    _.each(this.displayItems, (function (model) {
      view = new viewConstructor({
        model: model,
      });
      this.addSubview(".messages", view);
    }.bind(this)))


    if (this.subviews(".messages").length === 0) {
      this.$(".messages").html("Nothing new!");
    }
  },

})
