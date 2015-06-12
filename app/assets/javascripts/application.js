// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require autosize
//= require bootstrap
//= require faux-details
//= require moment.min
//= require Autolinker.min
//= require_tree .

(function($, moment) {
  $(function(){
    $('body').addClass('js-enabled');

    $('#decide-on-need-button').
      attr('href', '#decide-on-need-modal').
      attr('data-toggle', 'modal').
      attr('role', 'button');

    // Initiate any faux-details
    Maslow.fauxDetails.init();

    // use pretty dates for the updated time
    $("[data-updated-timestamp]").each(function(ind) {
      var $me = $(this),
          timestamp = $me.data('updated-timestamp');

      $me.text( moment( timestamp ).fromNow() );
    });

    // autolink links in notes
    var autolinker = new Autolinker({
      newWindow: false,
      hashtag: 'twitter'
    });
    $("p.note").each(function(idx) {
      var $me = $(this);
      $me.html(autolinker.link($me.text()));
    });
  });
}(jQuery, moment));
