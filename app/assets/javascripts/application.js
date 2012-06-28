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
//= require mustache
//= require_tree .

$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/deals/new', function (deal) {
    $('#deals').prepend(Mustache.to_html($('#deal_template').html(), deal));
    console.log(deal);
  });
  faye.subscribe('/tweets/new', function (tweet) {
    var new_tweet = $('#tweets').prepend(Mustache.to_html($('#tweet_template').html(), tweet));
    if ($("meta[name=current-user-name]").attr("content")) {
        $(new_tweet).append('<a href="/tweet_responses/new" class="btn btn-primary" id="tweet_response">Respond to tweet</a>');
      } else {
        $(new_tweet).append('<a href="/auth/twitter" class="btn btn-medium btn-primary">Login with Twitter to reply!</a>')};
  });
});