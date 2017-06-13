// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .
$(document).ready(function() {

  $('.delete-vote').on("submit", function(event) {
    event.preventDefault();
    $.ajax({
      method: "DELETE",
      url: "/api/v1/votes/:id",
      data: $(this).attr('action')

    }).done(function(response) {
      $("#up-vote-" + response.review.id).html("Up Votes: " + response.up_votes);
      $("#down-vote-" + response.review.id).html("Down Votes: " + response.down_votes);
    })
  });

  $('.vote').on("submit", function(event) {
    event.preventDefault();
    $.ajax({
      method: "POST",
      url: "/api/v1/votes",
      data: $(this).attr('action')

    }).done(function(response) {
      $("#up-vote-" + response.vote.review_id).html("Up Votes: " + response.up_votes);
      $("#down-vote-" + response.vote.review_id).html("Down Votes: " + response.down_votes);
    })
  });
});

$(function(){ $(document).foundation(); });
