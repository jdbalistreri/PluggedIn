ExtinctIn.Views.JobIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "job-index-item",

  template: JST["jobs/index-item"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click section.trigger" : "toggleJobInfo",
    "submit form" : "editJobSubmit",
    "click a.cancel" : "cancelForm",
    "click a.delete" : "deleteJob",
    "click input#check-present" : "toggleEndDate",
  },

  render: function () {
    console.log("render index item")
    var content = this.template({job: this.model});
    this.$el.html(content);

    this.selectCurrentDates()

    return this;
  },

  cancelForm: function () {
    this.toggleJobInfo();
    this.render();
  },

  deleteJob: function () {
    var modalView = new ExtinctIn.Views.JobModal({model: this.model})
    ExtinctIn.$modalEl.toggleClass("toggled");
    ExtinctIn.$modalEl.html(modalView.render().$el);
  },

  editJobSubmit: function (event) {
    event.preventDefault();
    var that = this;

    var $ul = this.$(".errors")
    $ul.empty();

    delete this.model.attributes["check_present"];

    var attrs = $(event.target).serializeJSON().experience;


    if ((!this.$("#check-present").prop("checked")) &&
        (this.$("#experience_end_date_2i").val() === "") ||
        (this.$(".experience_end_year").val() === "")) {

      $ul.append($("<li>").text("Please fill in both fields for end date"));
      return;
    }

    this.model.save(attrs, {
      success: function (model) {
        console.log(model)
        that.toggleJobInfo();
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

  toggleEndDate: function () {
    this.$(".end-date").toggleClass("toggled")
  },

  selectCurrentDates: function () {
    this.$el.find("#experience_start_date_2i").val(this.model.get("start_month"))
    this.$el.find("#experience_end_date_2i").val(this.model.get("end_month"))

    if (this.model.get("end_date") === null ) {
      this.$("input#check-present").prop("checked", true);
      this.toggleEndDate();
    }
  },

  toggleJobInfo: function () {
    if (ExtinctIn.currentUserId === this.model.get("user_id")) {
      this.$el.toggleClass("toggled");
    }
  },

})
