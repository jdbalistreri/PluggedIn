Backbone.ExperiencesForm = ExtinctIn.ToggleableFormView.extend({
  tagName: "li",

  events: function () {
    return _.extend({}, ExtinctIn.ToggleableFormView.prototype.events,{
      "click input#check-present" : "toggleEndDate",
    });
  },

  selectCurrentDates: function () {
    if (this.school()) {
      this.$el.find("#date_start_date_1i").val(this.model.get("start_year"));
      this.$el.find("#date_end_date_1i").val(this.model.get("end_year"));
      this.$el.find("#date_start_date_2i").val(1);
      this.$el.find("#date_end_date_2i").val(1);
    } else {
      this.$el.find("#date_start_date_2i").val(this.model.get("start_month"));
      this.$el.find("#date_end_date_2i").val(this.model.get("end_month"));

      if (this.model.get("end_date") === null ) {
        this.$("input#check-present").prop("checked", true);
        this.toggleEndDate();
      }
    }
  },

  school: function () {
    return this.model.get("type_str") === "School";
  },

  submitSetAttrs: function (event) {
    var attrs = $(event.target).serializeJSON();
    var date = attrs.date;
    delete attrs.date;
    return _.extend(attrs, date);
  },

  submitCancelCondition: function () {
    if (this.school()) return false
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
      this.$("button").html("Submit").prop("disabled", false);
      return false;
    }
    return true;
  },
});
