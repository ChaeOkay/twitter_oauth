$(document).ready(function() {
  $('#make_tweet').on('submit', function(e){
    e.preventDefault();
    var tweetMsg = $(this).serialize();
    console.log(tweetMsg);

    $.ajax({
      url: this.action,
      type: this.method,
      data: tweetMsg
    }).done(function(data){
      $('div.posted_tweet').html(data);
    });
  });
});
