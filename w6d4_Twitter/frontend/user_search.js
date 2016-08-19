const FollowToggle = require("./follow_toggle.js");

class UsersSearch {
  constructor(el) {
    this.$el = $(el);
    this.$input = this.$el.find("input[type='text']");
    this.$ul = this.$el.find("ul");
    this.$input.on("input", this.handleInput.bind(this));

  }

  render(result) {
    this.$ul.empty();
    let users = result;
    users.forEach(user => {
      let $link = $('<a>');
      $link.attr("href", `/users/${user.id}`);
      $link.text(`${user.username}`);
      let $li = $("<li>");

      let $button = $("<button>");
      this.buildButton($button, user);

      $li.append($link);
      $li.append($button);
      this.$ul.append($li);
    });
  }

  buildButton ($button, user) {
    $button.addClass("follow-toggle");
    $button.data("user-id", `${user.id}`);
    let followStatus;
    if (user.followed) {
      followStatus = "followed";
    } else {
      followStatus = "unfollowed";
    }
    $button.data("initial-follow-state", followStatus);
    new FollowToggle($button);
  }

  handleInput(e) {
    e.preventDefault();
    $.ajax({
      type: "GET",
      url: "/users/search",
      data: this.$input.serialize(),
      dataType: "json",
      success: (result) => {
        console.log();
        this.render(result);
      }
    });
  }
}






module.exports = UsersSearch;
