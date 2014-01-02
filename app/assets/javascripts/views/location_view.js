App.Views.LocationView = Backbone.View.extend({
  className: 'location',

  events: {
    'click .destroy': 'destroy',
  },

  destroy: function (e) {
    e.preventDefault();
    var source = $(e.target).parent();
    var model = this.data.get(source.data('location-id'));

    this.data.remove(model)
    // model.destroy();
  },

  initialize: function() {
    this.data = App.locations;
    this.data.fetch({reset: true});
    this.data.on("add remove change reset", this.render, this);
    this.render();

    return this;
  },
  render: function() {
    var template = JST['templates/location_list']({
      locations: this.data.toJSON()
    });

    this.$el.html(template);
    return this;
  }
});
