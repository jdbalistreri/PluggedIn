ExtinctIn.Views.JobForm = Backbone.View.extend({

  tagName: "li",
  className: "new-job-form",
  template: JST["jobs/new-form"],

  events: {
    "submit form" : "newJobSubmit",
    "click a.trigger" : "toggleNewJob",
    "click a.cancel" : "cancelForm",
    "click input#check-present" : "toggleEndDate",
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
  },

  cancelForm: function () {
    this.toggleNewJob();
    this.render();
  },

  newJobSubmit: function (event) {
    event.preventDefault();
    var that = this;

    var $ul = this.$(".errors")
    $ul.empty();

    if (!this.validEndDate($ul)) return;

    var attrs = $(event.target).serializeJSON().experience

    this.model.save(attrs, {
      success: function (model) {
        that.collection.add(model, {merge: true});
      },
      error: function (model, response) {
        response.responseJSON.forEach(function (error) {
          var $li = $("<li>").text(error);
          $ul.append($li);
        })
      },
    })
  },

  toggleEndDate: function () {
    this.$(".end-date").toggleClass("toggled")
  },

  toggleNewJob: function () {
    this.$el.toggleClass("toggled");
  },

  validEndDate: function (ul) {
    if ((!this.$("#check-present").prop("checked")) &&
        ((this.$("#experience_end_date_2i").val() === "") ||
        (this.$(".experience_end_year").val() === ""))) {

      ul.append($("<li>").text("Please fill in both fields for end date"));
      return false;
    }
    return true;
  },
})
