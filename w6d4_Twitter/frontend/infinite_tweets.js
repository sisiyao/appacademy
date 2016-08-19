class InfiniteTweets {
  constructor(el) {
    this.$el = $(el);
    $('.fetch-more').click(this.fetchTweets.bind(this));
    this.maxCreatedAt = null;
    $('#feed').on("insert-tweet", this.insertTweet.bind(this));
    $('.fetch-more').trigger("click");
  }

  fetchTweets(e) {
    e.preventDefault();
    $.ajax({
      url: "/feed",
      type: "GET",
      dataType: "json",
      data: {max_created_at: this.maxCreatedAt},
      success: (result) => {
        this.insertTweets(result);
        if (result.length < 20) {
          $('.fetch-more').remove();
          $(".infinite-tweets").append($("<p> End of tweets feed!</p>"));
        }
      },
    });
  }

  insertTweet(e, message) {
    let $li = $("<li>");
    $li.text(JSON.stringify(message));
    $("#feed").prepend($li);
  }

  insertTweets(result) {

    result.forEach((tweet, idx) => {
      let $li = $("<li>");
      $li.text(JSON.stringify(tweet));
      $("#feed").append($li);
      if (idx === result.length -1) {
        this.maxCreatedAt = tweet.created_at;
      }
    });
  }
}

module.exports = InfiniteTweets;
