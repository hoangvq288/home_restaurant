//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require admin-lte/dist/js/app.js
//= require 'icheck'
//= require_tree .

$(function () {
  $('input[type="checkbox"].i-check, input[type="radio"].i-check').iCheck({
    checkboxClass: 'icheckbox_flat-green',
    radioClass: 'iradio_flat-purple'
  });
})
