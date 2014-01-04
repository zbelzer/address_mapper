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
    this.data.on("add remove reset", this.render, this);
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

    if(code == App.Keys.ENTER) {
      var address = $(e.target).val().trim();
      var newLocation = new App.Models.Location({address: address});
      var self = this;

      newLocation.save(null, {
        success: function(result) {
          self.data.add(newLocation)
        },
        error: function(result, jqXHR) {
          var response = jQuery.parseJSON(jqXHR.responseText)
          self.showErrors($("div.new"), response)
        }
      });
    }
  },

  edit: function(e) {
    var $label = $(e.target);
    var $edit = $label.siblings(".edit")

    $label.toggle();
    $edit.toggle()
  },

  update: function(e) {
    var code = e.keyCode || e.which;

    if(code == 13) {
      e.preventDefault();

      var self = this;

      var $target = $(e.target);
      var $parent = $target.parent();

      var address = $target.val().trim();
      var model = this.data.get($parent.data('location-id'));

      model.save({address: address}, {
        success: function(model, response, options) {
          self.render();
        },
        error: function(model, jqXHR, options) {
          var response = jQuery.parseJSON(jqXHR.responseText)
          $target.show();
          console.log($target.get(0))
          self.showErrors($parent, response);
        }
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
    // Re-rendering has some side-effects, so we'll just do this.
    _.each(this.$el.find(".location").find("label"), function(label) {
      var $label = $(label);
      var $edit = $label.siblings(".edit");

      $label.show();

      $edit.val($label.text()); // Reset value
      $edit.hide()
    });

    this.$el.find("input").removeClass('error');
    this.$el.find(".errorMessage").remove();
  },

  showErrors: function(target, errors) {
    _.each(errors, function(error, fieldName) {
      var field = target.find('input[name="' + fieldName + '"]');
      var errorMessage = $('<div />').text("The " + fieldName + " " + error).addClass('errorMessage');
      field.addClass('error').after(errorMessage);
    });
  },

});
