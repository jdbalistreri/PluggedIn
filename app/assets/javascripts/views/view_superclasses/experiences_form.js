Backbone.ExperiencesForm = ExtinctIn.ToggleableFormView.extend({
  tagName: "li",

  events: function () {
    return _.extend({}, ExtinctIn.ToggleableFormView.prototype.events,{
      "click input#check-present" : "toggleEndDate",
    });
  },

  selectCurrentDates: function () {
    this.$el.find("#date_start_date_2i").val(this.model.get("start_month"))
    this.$el.find("#date_end_date_2i").val(this.model.get("end_month"))

    if (this.model.get("end_date") === null ) {
      this.$("input#check-present").prop("checked", true);
      this.toggleEndDate();
    }
  },

  submitSetAttrs: function (event) {
    var attrs = $(event.target).serializeJSON();
    var date = attrs.date;
    delete attrs.date;
    return _.extend(attrs, date);
  },

  submitCancelCondition: function () {
    return !this.validEndDate();
  },

  toggleEndDate: function () {
    this.$(".end-date").toggleClass("toggled")
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
});
