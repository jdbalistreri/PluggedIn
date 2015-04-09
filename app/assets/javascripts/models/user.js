PluggedIn.Models.User = Backbone.Model.extend({
  urlRoot: "api/users",

  parse: function (response) {
    if (response.jobs) {
      this.jobs().add(response.jobs);
      delete response.jobs;
    }

    if (response.schools) {
      this.schools().add(response.schools);
      delete response.schools;
    }

    if (response.cu_connection) {
      this.cu_connection().set(response.cu_connection);
      delete response.cu_connection;
    }

    return response;
  },

  toJSON: function () {
    return {user: _.clone(this.attributes)};
  },

  cu_connection: function () {
    if (!this._cu_connection) {
      this._cu_connection = new PluggedIn.Models.Connection();
    }
    return this._cu_connection;
  },

  jobs: function () {
    if (!this._jobs) {
      this._jobs = new PluggedIn.Collections.Experiences([], {type: "Job"});
    }

    return this._jobs;
  },

  schools: function () {
    if (!this._schools) {
      this._schools = new PluggedIn.Collections.Experiences([], {type: "School"});
    }

    return this._schools;
  },
});
