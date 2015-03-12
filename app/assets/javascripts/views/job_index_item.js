ExtinctIn.Views.JobIndexItem = Backbone.ToggleableFormView.extend({

  tagName: "li",
  className: "job-index-item",
  template: JST["jobs/index-item"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: function () {
    return _.extend({}, Backbone.ToggleableFormView.prototype.events,{
      "click input#check-present" : "toggleEndDate",
    });
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);

    this.selectCurrentDates()

    return this;
  },

  submitSetAttrs: function (event) {
    var attrs = $(event.target).serializeJSON();
    var date = attrs.date;
    delete attrs.date;
    return _.extend(attrs, date);
  },

  submitCancelCondition: function () {
    return !this.validEndDate()
  },

  submitBeforeSave: function () {
    delete this.model.attributes["check_present"];
  },

  submitOnSuccess: function () {
    this.toggleEl();
    this.model.collection.sort();
  },


  // EXPERIENCE SPECIFIC METHODS
  selectCurrentDates: function () {
    this.$el.find("#date_start_date_2i").val(this.model.get("start_month"))
    this.$el.find("#date_end_date_2i").val(this.model.get("end_month"))

    if (this.model.get("end_date") === null ) {
      this.$("input#check-present").prop("checked", true);
      this.toggleEndDate();
    }
  },

  validEndDate: function () {
    if ((!this.$("#check-present").prop("checked")) &&
        ((this.$("#date_end_date_2i").val() === "") ||
        (this.$(".date_end_year").val() === ""))) {

      this.$(".errors").append($("<li>").text("Please fill in both fields for end date"));
      return false;
    }
    return true;
  },

  toggleEndDate: function () {
    this.$(".end-date").toggleClass("toggled")
  },

})
