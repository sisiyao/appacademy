const FollowToggle = require("./follow_toggle.js");
const UsersSearch = require("./user_search.js");
const TweetCompose = require("./tweet_compose.js");
const InfiniteTweets = require("./infinite_tweets.js");

$( () => {
  let $buttons = $(".follow-toggle");
  $buttons.each((idx, el) => {
    new FollowToggle(el);
  });
  let $usersSearch = $(".users-search");
  $usersSearch.each((idx, el) => {
    new UsersSearch(el);
  });
  let $tweetCompose = $(".tweet-compose");
  $tweetCompose.each((idx, el) => {
    new TweetCompose(el);
  });
  let $infiniteTweets = $(".infinite-tweets");
  $infiniteTweets.each((idx, el) => {
    new InfiniteTweets(el);
  });

}
);
