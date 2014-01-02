App.Views.Map = Backbone.View.extend({
  initialize: function() {
    App.locations.on("add remove change reset", this.render, this);

    this.markers = {};
    this.center = new google.maps.LatLng(41.88, -87.62);
    this.bounds = new google.maps.LatLngBounds ();
    this.map = new google.maps.Map(document.getElementById("map-canvas"), {
      center: this.center, zoom: 13
    });
    this.geocoder = new google.maps.Geocoder();
  },

  render: function(e) {
    var self = this;

    this.clearMap();

    _.each(App.locations.toJSON(), function(location) {
      self.geocoder.geocode( { 'address': location.address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          self.addMarker(results[0].geometry.location)
        } else {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
    });
  },

  addMarker: function(coords) {
    this.markers[coords] = new google.maps.Marker({
      map: this.map,
      position: coords
    });

    this.bounds.extend(coords);
    this.map.fitBounds(this.bounds);
  },

  removeMarker: function(coords) {
    this.markers[coords].setMap(null);
    delete this.markers[coords];
  },

  clearMap: function() {
    var self = this;
    _.each(this.markers, function(value, key, list) {
      self.removeMarker(key);
    });
  },
});
