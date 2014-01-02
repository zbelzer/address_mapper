App.Collections.LocationList = Backbone.Collection.extend({
  url: 'locations',
  model: App.Models.Location 
});

App.locations = new App.Collections.LocationList();
