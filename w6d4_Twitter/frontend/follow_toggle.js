class FollowToggle {
  constructor(el) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id");
    this.followState = this.$el.data("initial-follow-state");
    this.render();
    this.$el.on("click", this.handleClick.bind(this));
  }

  render() {

    if (this.followState === "followed") {
      this.$el.text("Unfollow!");
      this.$el.prop('disabled', false);
    } else if (this.followState === "unfollowed"){
      this.$el.text("Follow!");
      this.$el.prop('disabled', false);
    } else {
      this.$el.text(`${this.followState}...`);
      this.$el.prop('disabled', true);
    }

  }

  handleClick(e) {
    e.preventDefault();
    if (this.followState === "unfollowed") {
      this.followState = "Following";
      this.render();
      $.ajax({
        type: "POST",
        url: `/users/${this.userId}/follow`,
        data: this.$el.serialize(),
        dataType: "json",
        success:
          () => {
            this.followState = "followed";
            this.render();
          }
      });
    } else if (this.followState === "followed") {
      this.followState = "Unfollowing";
      this.render();
      $.ajax({
        type: "DELETE",
        url: `/users/${this.userId}/follow`,
        data: this.$el.serialize(),
        dataType: "json",
        success:
          () => {
            this.followState = "unfollowed";
            this.render();
          }
      });
    }
  }
}



module.exports = FollowToggle;
