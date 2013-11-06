$(document).ready(function() {

  $(".upvote-post, .downvote-post").on('submit', function(event) {
    event.preventDefault();
    var form = this;

    var url = $(form).attr("action");

    $.post(url, function(response) {
      $("#post-points").html($(response).find("#post-points").html());
    });
  });

  $(".comment-upvote-form, .comment-downvote-form").on('submit', function(event) {
    event.preventDefault();
    var form = this;
    // console.log(form);

    var url = $(form).attr("action");

    $.post(url, function(response){
      var comment_id = $(form).find(".comment-id-target").attr("value");
      var comment_points_target = "#comment-points-"+ comment_id;
      $(comment_points_target).html($(response).find(comment_points_target).html());
    });

  });

})