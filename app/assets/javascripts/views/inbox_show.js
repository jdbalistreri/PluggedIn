ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.inbox = options.inbox;
    this.subview = options.subview;
    this.type = options.type;
    this.direction = options.direction;


    if (this.inbox) {
      this.updateValues();
      this.listenTo(this.inbox, "sync", this.updateValues);
    }
  },

  template: JST["inbox/show"],

  render: function (){
    var content = this.template();
    this.$el.html(content);
    this.emptySubviews(".messages");

    if (this.subview) {
      this.addSubview(".messages", this.subview)
    } else {
      this.fillInbox();
    }

    return this;
  },

  updateValues: function () {
    this.displayItems = this.inbox[this.type]()[this.direction]();
    this.render()
  },

  fillInbox: function () {

    if (this.displayItems[0] instanceof ExtinctIn.Models.Connection) {
      var viewConstructor = ExtinctIn.Views.ConnectionIndexItem;
    } else {
      var viewConstructor = ExtinctIn.Views.MessageIndexItem;
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
