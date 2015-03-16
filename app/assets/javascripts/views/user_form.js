ExtinctIn.Views.UserForm = ExtinctIn.ToggleableFormView.extend({

  template: JST["users/form"],
  tagName: "form",
  
  events: function () {
    return _.extend({}, ExtinctIn.ToggleableFormView.prototype.events,{
      "change input#user-picture" : "changePicture",
    });
  },

  render: function() {
    var content = this.template({user: this.model});
    this.$el.html(content);
    return this;
  },

  changePicture: function (event) {
    var that = this;
    var file = event.currentTarget.files[0];
    var fileReader = new FileReader();

    fileReader.onloadend = function () {
      that.model.set("picture", fileReader.result);
      that.$("#picture-preview").attr("src", fileReader.result)
    };

    fileReader.readAsDataURL(file);
  },

  submitOnSuccess: function () {
    this.toggleEl();
  },

})
