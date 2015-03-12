ExtinctIn.Views.JobForm = Backbone.ToggleableFormView.extend({

  tagName: "li",
  className: "new-job-form",
  template: JST["jobs/new-form"],

  events: function () {
    return _.extend({}, Backbone.ToggleableFormView.prototype.events,{
      "click input#check-present" : "toggleEndDate",
    });
  },

  render: function () {
    var content = this.template({job: this.model});
    this.$el.html(content);
    return this;
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

  submitOnSuccess: function (model) {
    this.collection.add(model, {merge: true});
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
})
