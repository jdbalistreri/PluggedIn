ExtinctIn.Views.JobIndexItem = Backbone.ToggleableFormView.extend({

  tagName: "li",
  className: "job-index-item",
  template: JST["jobs/index-item"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: function () {
    return _.extend({}, Backbone.ToggleableFormView.prototype.events,{
      "submit form" : "editJobSubmit",
      "click input#check-present" : "toggleEndDate",
    });
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);

    this.selectCurrentDates()

    return this;
  },

  editJobSubmit: function (event) {
    event.preventDefault();
    var that = this;

    var $ul = this.$(".errors")
    $ul.empty();

    delete this.model.attributes["check_present"];

    if (!this.validEndDate()) return;

    var attrs = $(event.target).serializeJSON().experience;

    this.model.save(attrs, {
      success: function (model) {
        that.toggleEl();
        that.model.collection.sort();
      },
      error: function (model, response) {
        response.responseJSON.forEach(function (error) {
          var $li = $("<li>").text(error);
          $ul.append($li);
        })
      },
    });
  },

  submitCancelCondition: function () {
    return false;
  },

  submitBeforeSave: function () {

  },

  submitOnSuccess: function () {
    this.toggleEl();
    this.model.collection.sort();
  },


  // EXPERIENCE SPECIFIC METHODS
  selectCurrentDates: function () {
    this.$el.find("#experience_start_date_2i").val(this.model.get("start_month"))
    this.$el.find("#experience_end_date_2i").val(this.model.get("end_month"))

    if (this.model.get("end_date") === null ) {
      this.$("input#check-present").prop("checked", true);
      this.toggleEndDate();
    }
  },

  validEndDate: function () {
    if ((!this.$("#check-present").prop("checked")) &&
        ((this.$("#experience_end_date_2i").val() === "") ||
        (this.$(".experience_end_year").val() === ""))) {

      this.$(".errors").append($("<li>").text("Please fill in both fields for end date"));
      return false;
    }
    return true;
  },

  toggleEndDate: function () {
    this.$(".end-date").toggleClass("toggled")
  },

})
