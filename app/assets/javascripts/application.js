// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require jquery.turbolinks
//= bootstrap-select
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .

var delay = 5000,                                                               // Delay in microseconds to update markers on map

callout = function () {
  $.ajax({
    type: 'GET',
    url: '/new_claims',
    async: true,
    beforeSend: function (xhr) {
      if (xhr && xhr.overrideMimeType) {
        xhr.overrideMimeType('application/json;charset=utf-8');
      }
    },
    dataType: 'json',
    error: function () {
      $("#new_claim").text("Помилка модуля заяв!");
      $("#empty_list").show();
    },
    success: function (data) {
      if (!$.isArray(data) || !data.length) {
        $("#new_claim").hide();
      } else {
        $("#new_claim").show();
      }
    }
  }).always(function () {
      setTimeout(callout, delay);
  });
};

callout();
