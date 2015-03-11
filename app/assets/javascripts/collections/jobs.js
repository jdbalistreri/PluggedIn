ExtinctIn.Collections.Jobs = Backbone.Collection.extend({
  url: "api/experiences",
  model: ExtinctIn.Models.Job,

  initialize: function (models, options) {
    this.user = options.user;
  },

  comparator: function (modelA, modelB) {
    // debugger
    if (modelA.get("end_year") === null) {
      if (modelB.get("end_year") === null) {
        return this.startDateSort(modelA, modelB);
      } else {
        return -1;
      }
    } else if (modelB.get("end_year") === null) {
      return 1;
    } else {
      return this.startDateSort(modelA, modelB);
    }
  },

  startDateSort: function (modelA, modelB) {
    if (modelA.get("start_year") === modelB.get("start_year")) {
      if (modelA.get("start_month") === modelB.get("start_month")) {
        return 0;
      } else if (modelA.get("start_month") < modelB.get("start_month")) {
        return 1;
      } else {
        return -1;
      }
    } else if (modelA.get("start_year") < modelB.get("start_year")) {
      return 1;
    } else {
      return -1;
    }
  },

})
