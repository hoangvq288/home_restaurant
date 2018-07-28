//= require jquery
//= require jquery_ujs
//= require lodash
//= require bootstrap-sprockets
//= require admin-lte/dist/js/app.js
//= require 'icheck'
//= require_tree .

$(function () {
  // Init i-check checkboxes
  $('input[type="checkbox"].i-check, input[type="radio"].i-check').iCheck({
    checkboxClass: 'icheckbox_flat-green',
    radioClass: 'iradio_flat-purple'
  });

  // Active menu settings
  $(window).load(function(){
    var current_location = $(location).attr('pathname');
    $("ul.sidebar-menu > li > a").each(function() {
      $t = $(this);
      if ($t.attr('href') == current_location) {
        $t.parent().addClass('active');
      }
      else {
        $t.parent().removeClass('active');
      }
    })
  });

  // Change pagination per_page
  $('.will_paginate_per_page').change(function () {
    const $t = $(this);
    window.location.href = "?per_page=" + $t.val();
  });
})
