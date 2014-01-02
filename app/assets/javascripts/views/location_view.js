App.Views.LocationView = Backbone.View.extend({
  className: 'location',

  events: {
    'click .location .destroy': 'destroy',
    'click .location label': 'edit',
    'keypress .new': 'create',
    'keypress .edit': 'update',
    'blur .location input': 'revert'
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
  },

  create: function(e) {
    var code = e.keyCode || e.which;

    if(code == 13) {
      var address = $(e.target).val().trim();
      var newLocation = new App.Models.Location({address: address});
      var self = this;

      newLocation.save(null, {
        success: function(result) {
          self.data.add(newLocation)
        },
        error: function(result, jqXHR) {
          alert(jqXHR.responseText)
        }
      });
    }
  },

  edit: function(e) {
    this.revert();

    var $label = $(e.target);
    var $edit = $label.siblings(".edit")

    $label.toggle();
    $edit.toggle()
  },

  update: function(e) {
    var code = e.keyCode || e.which;

    if(code == 13) {
      var self = this;

      var $target = $(e.target);
      var $parent = $target.parent();

      var address = $target.val().trim();
      var model = this.data.get($parent.data('location-id'));

      model.save({address: address}, {
        success: function() { self.revert(); }
      });
    }
  },

  destroy: function (e) {
    e.preventDefault();

    var source = $(e.target).parent();
    var model = this.data.get(source.data('location-id'));

    model.destroy();
    this.data.remove(model)
  },

  revert: function(e) {
    $(".location label").show();
    $(".location .edit").hide();
  },

});
