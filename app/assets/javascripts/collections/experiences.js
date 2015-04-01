PluggedIn.Collections.Experiences = Backbone.Collection.extend({
  url: "api/experiences",

  model: function (attrs) {
    var type = attrs.type_str;
    return new PluggedIn.Models[type](attrs);
  },

  comparator: function (modelA, modelB) {
    if (modelA instanceof PluggedIn.Models.Job) {
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
    } else {
      var maxA = modelA.get("end_year") || modelA.get("start_year");
      var minA = modelA.get("start_year") || modelA.get("end_year");
      var maxB = modelB.get("end_year") || modelB.get("start_year");
      var minB = modelB.get("start_year") || modelB.get("end_year");

      if (maxA === maxB) {
        if (minA === minB) {
          return 0
        } else if (minA < minB) {
          return 1
        } else {
          return -1
        }
      } else if (maxA < maxB) {
        return 1
      } else {
        return -1
      }
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
