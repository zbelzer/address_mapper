var App = {
  Models: {},
  Collections: {},
  Views: {},
  Keys: {
    ENTER: 13
  }
};

$(function () {
  App.locationView = new App.Views.LocationView({el: $("#locations")});
  App.map = new App.Views.Map();

  Backbone.history.start();
});
