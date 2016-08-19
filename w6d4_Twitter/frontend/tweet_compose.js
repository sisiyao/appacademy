class TweetCompose {
  constructor(el) {
    this.$el = $(el);
    this.formState = "enabled";
    this.$el.on("submit", this.submitTweet.bind(this));
    this.$el.find("textarea").on("input", this.charLeft.bind(this));
    $(".add-mentioned-user").on("click", this.addMentionedUser.bind(this));
    $(".mentioned-users").on("click", ".remove-mentioned-user", this.removeMentionedUser.bind(this));
  }


  render() {
    if (this.state === "disabled") {
      $(".tweet-compose:input").prop('disabled', true);
    } else {
      $(".tweet-compose:input").prop('disabled', false);
    }
  }

  addMentionedUser(e) {
    e.preventDefault();
    let $script = this.$el.find("script");
    $('.mentioned-users').append($script.html());
  }

  removeMentionedUser(e) {
    e.preventDefault();
    let $mentionedUser = $(e.currentTarget);
    $mentionedUser.parent().remove();
  }


  charLeft(e) {
    e.preventDefault();
    $('.chars-left').text(`${140 - $('textarea').val().length} characters left`);
    this.render();
  }

  submitTweet(e) {
    e.preventDefault();
    let formData = this.$el.serialize();
    this.formState = "disabled";
    this.render();

    $.ajax({
      url: "/tweets",
      dataType: "json",
      data:formData,
      type: "POST",
      success: (result) => {
        this.handleSuccess(result);
        this.clearInput();
        this.formState = "enabled";
        this.render();
      }
    });
  }

  clearInput() {
    $(".tweet-compose:input").val("");
    $(".mentioned-users").empty();
  }

  handleSuccess(result) {
    let $ul = $(this.$el.data("tweets-ul"));

    $ul.trigger("insert-tweet", [result]);

    // let $li = $(`<li> ${result.content} -- <a href="/users/${result.user.id}">${result.user.username}</a> -- ${result.created_at} </li>`);
    // $ul.prepend($li);
  }
}

module.exports = TweetCompose;
