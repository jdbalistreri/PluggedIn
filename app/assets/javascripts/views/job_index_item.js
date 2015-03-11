ExtinctIn.Views.JobIndexItem = Backbone.View.extend({

  tagName: "li",
  className: "job-index-item",

  template: JST["jobs/index-item"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "dblclick .trigger" : "toggleJobInfo",
    "click a.edit-form" : "toggleJobInfo",
    "submit form" : "editJobSubmit",
    "click a.cancel" : "cancelForm",
    "click a.delete" : "deleteJob",
    "click input#check-present" : "toggleEndDate",
  },

  render: function () {
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
    event.preventDefault();".end-date".toggleClass("hidden-input")
    var that = this;

    var $ul = this.$(".errors")
    $ul.empty();

    var attrs = $(event.target).serializeJSON().experience;

    this.model.save(attrs, {
      success: function (model) {
        that.toggleJobInfo();
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
