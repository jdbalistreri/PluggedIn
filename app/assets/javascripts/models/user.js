ExtinctIn.Models.User = Backbone.Model.extend({
  urlRoot: "api/users",

  parse: function (response) {
    if (response.jobs) {
      this.jobs().add(response.jobs)
      delete response.jobs
    }

    if (response.schools) {
      this.schools().add(response.schools)
      delete response.schools
    }

    return response
  },

  jobs: function () {
    if (!this._jobs) {
      this._jobs = new ExtinctIn.Collections.Jobs({user: this})
    }

    return this._jobs
  },

  schools: function () {
    if (!this._schools) {
      this._schools = new ExtinctIn.Collections.Schools({user: this})
    }

    return this._schools
  },
})
