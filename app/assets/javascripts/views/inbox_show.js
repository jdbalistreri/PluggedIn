ExtinctIn.Views.InboxShow = Backbone.CompositeView.extend({

  initialize: function(options) {
    this.subview = options.subview;
    // if (this.collection) {
    //   this.listenTo(this.collection, "sync", this.render);
    // }
  },

  template: JST["inbox/show"],

  render: function (){
    var content = this.template();
    this.$el.html(content);
    this.emptySubviews(".messages");

    if (this.subview) {
      this.addSubview(".messages", this.subview)
    } else {
      this.fillInbox(this.collection);
    }

    return this;
  },

  fillInbox: function (collection) {

    if (collection instanceof ExtinctIn.Collections.Connections) {
      var viewConstructor = ExtinctIn.Views.ConnectionIndexItem;
    } else {
      var viewConstructor = ExtinctIn.Views.MessageIndexItem;
    }

    _.each(collection, (function (model) {
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
