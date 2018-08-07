//= require jquery
//= require jquery_ujs
//= require lodash
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require moment
//= require daterangepicker
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

  // Date range picker && init empty value
  $('.date-range').daterangepicker({
    autoUpdateInput: false,
    locale: {
      format: 'YYYY-MM-DD',
      cancelLabel: 'Clear'
    }
  });

  $('.date-range').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('YYYY/MM/DD') + ' - ' + picker.endDate.format('YYYY/MM/DD'));
  });

  $('.date-range').on('cancel.daterangepicker', function(ev, picker) {
      $(this).val('');
  });

})
