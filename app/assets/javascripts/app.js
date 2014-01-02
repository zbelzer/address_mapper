var App = {
  Models: {},
  Collections: {},
  Views: {}
};

$(function () {
  App.locationView = new App.Views.LocationView({el: $("#locations")});
  App.map = new App.Views.Map();

  Backbone.history.start();
});
